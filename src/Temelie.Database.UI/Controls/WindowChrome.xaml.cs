using System.Windows;

namespace Temelie.Database
{
    namespace Controls
    {
        /// <summary>
        /// Interaction logic for CaptionButtons.xaml
        /// </summary>
        public partial class WindowChrome
        {

            /// <summary>
            /// The parent Window of the control.
            /// </summary>
            private Window _parent;

            #region Properties

            /// <summary>
            /// Gets or sets the margin button.
            /// </summary>
            /// <value>The margin button.</value>
            public Thickness MarginButton
            {
                get
                {
                    return (Thickness)GetValue(MarginButtonProperty);
                }
                set
                {
                    base.SetValue(MarginButtonProperty, value);
                }
            }

            /// <summary>
            /// The dependency property for the Margin between the buttons.
            /// </summary>
            public static DependencyProperty MarginButtonProperty = DependencyProperty.Register("MarginButton", typeof(Thickness), typeof(WindowChrome));

            /// <summary>
            /// Enum of the types of caption buttons
            /// </summary>
            public enum CaptionType
            {
                /// <summary>
                /// All the buttons
                /// </summary>
                Full,
                /// <summary>
                /// Only the close button
                /// </summary>
                Close,
                /// <summary>
                /// Reduce and close buttons
                /// </summary>
                ReduceClose
            }

            /// <summary>
            /// Gets or sets the visibility of the buttons.
            /// </summary>
            /// <value>The visible buttons.</value>
            public CaptionType Type
            {
                get
                {
                    return (CaptionType)GetValue(TypeProperty);
                }
                set
                {
                    base.SetValue(TypeProperty, value);
                }
            }

            /// <summary>
            /// The dependency property for the Margin between the buttons.
            /// </summary>
            public static DependencyProperty TypeProperty = DependencyProperty.Register("Type", typeof(CaptionType), typeof(WindowChrome), new PropertyMetadata(CaptionType.Full));

            #endregion

            #region Event Handlers

            /// <summary>
            /// Event when the control is loaded.
            /// </summary>
            /// <param name="sender">The sender.</param>
            /// <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
            private void WindowChrome_Loaded(object sender, RoutedEventArgs e)
            {
                _parent = GetTopParent();
            }

            /// <summary>
            /// Action on the button to close the window.
            /// </summary>
            /// <param name="sender">The sender.</param>
            /// <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
            private void CloseButtonClick(object sender, RoutedEventArgs e)
            {
                _parent.Close();
            }

            /// <summary>
            /// Changes the view of the window (maximized or normal).
            /// </summary>
            /// <param name="sender">The sender.</param>
            /// <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
            private void RestoreButtonClick(object sender, RoutedEventArgs e)
            {
                _parent.WindowState = (_parent.WindowState == WindowState.Maximized) ? WindowState.Normal : WindowState.Maximized;
            }

            /// <summary>
            /// Minimizes the Window.
            /// </summary>
            /// <param name="sender">The sender.</param>
            /// <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
            private void MinimizeButtonClick(object sender, RoutedEventArgs e)
            {
                _parent.WindowState = WindowState.Minimized;
            }

            #endregion

            #region Methods

            /// <summary>
            /// Gets the top parent (Window).
            /// </summary>
            /// <returns>The parent Window.</returns>
            private Window GetTopParent()
            {
                return Window.GetWindow(this);
            }

            #endregion

            public WindowChrome()
            {
                this.InitializeComponent();
                SubscribeToEvents();
            }

            private bool EventsSubscribed;
            private void SubscribeToEvents()
            {
                if (EventsSubscribed)
                {
                    return;
                }
                else
                {
                    EventsSubscribed = true;
                }

                this.Loaded += WindowChrome_Loaded;
            }

        }
    }

}
