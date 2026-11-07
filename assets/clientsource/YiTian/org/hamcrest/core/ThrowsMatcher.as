package org.hamcrest.core
{
   import org.hamcrest.Description;
   import org.hamcrest.Matcher;
   import org.hamcrest.TypeSafeDiagnosingMatcher;
   
   public class ThrowsMatcher extends TypeSafeDiagnosingMatcher
   {
      
      private var _matcher:Matcher;
      
      public function ThrowsMatcher(matcher:Matcher)
      {
         super(Function);
         _matcher = matcher;
      }
      
      override public function describeTo(description:Description) : void
      {
         description.appendDescriptionOf(_matcher).appendText(" to be thrown");
      }
      
      override public function matchesSafely(item:Object, mismatchDescription:Description) : Boolean
      {
         var closure:Function = item as Function;
         var thrown:Boolean = false;
         var error:Error = null;
         try
         {
            closure();
         }
         catch(e:Error)
         {
            error = e;
            if(!_matcher.matches(e))
            {
               throw e;
            }
            thrown = true;
         }
         finally
         {
            if(Boolean(error))
            {
               mismatchDescription.appendMismatchOf(_matcher,error);
            }
            else
            {
               mismatchDescription.appendText("was not thrown");
            }
            return thrown;
         }
      }
   }
}

