(function str (*args)
  (set result "")
  (*args eachWithIndex:
    (do (arg idx)
      (if (not (string? arg))
        (map (do (method)
               (if (arg respondsToSelector:method)
                 (set arg (arg performSelector:method))))
          '("stringValue" "description"))

        (if (not (string? arg))
          (NSLog "Argument at index #{idx} does not implement description")))

      (set result (result stringByAppendingString:arg))))
  result)

(function log (*args)
  (NSLog (str *args)))

(function nth (lst i)
  (if (and (lst respondsToSelector:"objectAtIndex:") (< i (lst count)))
    (lst objectAtIndex:i)
    (else nil)))

(function alert (*args)
  (let ((title   (str (nth *args 0)))
        (message (str (nth *args 1))))
    (set alertView ((UIAlertView alloc) initWithTitle:title 
                                              message:message delegate:nil 
                                    cancelButtonTitle:"Dismiss" otherButtonTitles:nil))
    (alertView show)))