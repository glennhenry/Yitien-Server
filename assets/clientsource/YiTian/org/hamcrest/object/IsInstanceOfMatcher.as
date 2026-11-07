package org.hamcrest.object
{
   import flash.utils.getQualifiedClassName;
   import org.hamcrest.BaseMatcher;
   import org.hamcrest.Description;
   
   public class IsInstanceOfMatcher extends BaseMatcher
   {
      
      private var _typeName:String;
      
      private var _type:Class;
      
      public function IsInstanceOfMatcher(type:Class)
      {
         super();
         _type = type;
         _typeName = getQualifiedClassName(type);
      }
      
      override public function describeTo(description:Description) : void
      {
         description.appendText("an instance of ").appendText(_typeName);
      }
      
      override public function matches(item:Object) : Boolean
      {
         return item is _type;
      }
   }
}

