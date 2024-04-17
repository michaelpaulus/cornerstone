using System.Text;
using Microsoft.CodeAnalysis;
using Temelie.Repository.SourceGenerator;

namespace Temelie.Entities.SourceGenerator;

[Generator]
public class DbContextIncrementalGenerator : IIncrementalGenerator
{

    public void Initialize(IncrementalGeneratorInitializationContext context)
    {
        var compliationProvider = context.CompilationProvider.Select(static (compilation, token) =>
        {
            var visitor = new EntitySymbolVisitor();
            visitor.Visit(compilation.GlobalNamespace);
            return (compilation.AssemblyName, visitor.Entities);
        });

        context.RegisterImplementationSourceOutput(compliationProvider, (context, results) =>
        {
            Generate(context, results.AssemblyName, results.Entities);
        });
    }

    void Generate(SourceProductionContext context, string assemblyName, IEnumerable<Entity> entities)
    {
        var ns = assemblyName;

        var sbModelBuilder = new StringBuilder();
        var sbRepositoryContext = new StringBuilder();
        var sbImplements = new StringBuilder();
        var sbExports = new StringBuilder();

        void addEntity(Entity entity)
        {
            var className = entity.FullType.Split('.').Last();

            sbImplements.Append($@",
                                     IRepositoryContext<{entity.FullType}>");
            sbExports.AppendLine($"[ExportTransient(typeof(IRepositoryContext<{entity.FullType}>))]");

            sbRepositoryContext.AppendLine($@"
    public DbSet<{entity.FullType}> {className} {{ get; set; }}
    DbContext IRepositoryContext<{entity.FullType}>.DbContext => this;
    DbSet<{entity.FullType}> IRepositoryContext<{entity.FullType}>.DbSet => {className};
");

            var props = new StringBuilder();
            var keys = new List<string>();

            foreach (var column in entity.Properties.OrderBy(i => i.Order))
            {
                var columnProperties = new StringBuilder();

                if (column.IsEntityId)
                {
                    columnProperties.AppendLine();
                    if (column.IsNullable)
                    {
                        columnProperties.Append($"                .HasConversion(id => id.HasValue ? id.Value.Value : default, value => new {column.FullType}(value))");
                    }
                    else
                    {
                        columnProperties.Append($"                .HasConversion(id => id.Value, value => new {column.FullType}(value))");
                    }
                }

                if (column.IsPrimaryKey)
                {
                    keys.Add(column.Name);
                }

                if (column.IsIdentity)
                {
                    columnProperties.AppendLine();
                    columnProperties.Append($"                .UseIdentityColumn(_serviceProvider)");
                }

                if (column.ColumnName != column.Name)
                {
                    columnProperties.AppendLine();
                    columnProperties.Append($"                .HasColumnName(\"{column.ColumnName}\")");
                }

                if (columnProperties.Length > 0)
                {
                    props.Append($@"
            builder.Property(p => p.{column.Name}){columnProperties};");
                }
            }

            var config = new StringBuilder();

            if (keys.Count > 1)
            {
                config.AppendLine($"            builder.HasKey(i => new {{ {string.Join(", ", keys.Select(i => $"i.{i}"))} }});");
            }
            else if (keys.Count == 1)
            {
                config.AppendLine($"            builder.HasKey(i => i.{keys[0]});");

            }
            else
            {
                config.AppendLine($"            builder.HasNoKey();");
            }

            if (entity.IsView)
            {
                config.AppendLine($"            builder.ToView(\"{entity.TableName}\");");
            }
            else
            {
                config.AppendLine($"            builder.ToTable(\"{entity.TableName}\");");
            }

            sbModelBuilder.AppendLine($@"
        modelBuilder.Entity<{entity.FullType}>(builder =>
        {{
{config}
{props}
        }});
");
        }

        foreach (var entity in entities)
        {
            addEntity(entity);
        }

        var sb = new StringBuilder();

        sb.AppendLine($@"using Microsoft.EntityFrameworkCore;
using Temelie.DependencyInjection;
using Temelie.Repository;
using Temelie.Repository.EntityFrameworkCore;

namespace {ns};

{sbExports}public abstract partial class DbContextBase : DbContext{sbImplements}
{{

    private readonly IServiceProvider _serviceProvider;

    public DbContextBase(IServiceProvider serviceProvider, DbContextOptions options) : base(options)
    {{
        _serviceProvider = serviceProvider;
    }}

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {{
        base.OnModelCreating(modelBuilder);
        {sbModelBuilder}
    }}

    {sbRepositoryContext}
}}
");

        context.AddSource($"{ns}.DbContextBase.g", sb.ToString());
    }

}
