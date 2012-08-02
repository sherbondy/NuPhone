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