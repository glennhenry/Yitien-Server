package org.hamcrest.core
{
   import org.hamcrest.Matcher;
   import org.hamcrest.object.instanceOf;
   
   public function throws(error:Object) : Matcher
   {
      if(error is Class)
      {
         return org.hamcrest.core.throws(instanceOf(error as Class));
      }
      if(error is Matcher)
      {
         return new ThrowsMatcher(error as Matcher);
      }
      throw new ArgumentError("error must be either Class or Matcher");
   }
}

