package org.hamcrest
{
   import flash.errors.IllegalOperationError;
   
   public class TypeSafeDiagnosingMatcher extends BaseMatcher
   {
      
      private var _expectedType:Class;
      
      public function TypeSafeDiagnosingMatcher(expectedType:Class)
      {
         super();
         _expectedType = expectedType;
      }
      
      override public function matches(item:Object) : Boolean
      {
         return item != null && item is _expectedType && matchesSafely(item,new NullDescription());
      }
      
      override public function describeMismatch(item:Object, mismatchDescription:Description) : void
      {
         matchesSafely(item,mismatchDescription);
      }
      
      public function matchesSafely(item:Object, mismatchDescription:Description) : Boolean
      {
         throw new IllegalOperationError("TypeSafeDiagnosingMatcher#matchesSafely is abstract and must be override in subclass");
      }
   }
}

