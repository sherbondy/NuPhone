(load "nu")
(load "cocoa")

(class NPAppDelegate is UIResponder
    (ivar (id) window 
          (id) rootVC)

    (- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)launchOptions is
        ;; Set up the window and content view
        (NSLog "testing")
        (set screenRect ((UIScreen mainScreen) bounds))
        (set @window ((UIWindow alloc) initWithFrame:screenRect))
        (@window setBackgroundColor:(UIColor whiteColor))
        
        (set @rootVC ((UIViewController alloc) init))
        (@window setRootViewController:@rootVC)
        
        ;; Show the window
        (@window makeKeyAndVisible)))
