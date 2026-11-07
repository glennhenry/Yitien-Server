package com.yiTian.utils
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.RadioButton;
   import com.ui.controls.RadioButtonGroup;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.system.ApplicationDomain;
   
   public class ViewerCreator
   {
      
      public function ViewerCreator()
      {
         super();
      }
      
      public static function createViewer(viewerInfo:Array, basicParent:DisplayObjectContainer) : void
      {
         var infoArr:Object = null;
         var parent:DisplayObjectContainer = null;
         var cla:Class = null;
         var property:Object = null;
         var text:String = null;
         var obj:Object = null;
         var style:String = null;
         var dm:ApplicationDomain = null;
         var tbStyle:String = null;
         var rbStyle:String = null;
         for each(infoArr in viewerInfo)
         {
            cla = infoArr[0];
            property = infoArr[1];
            if(Boolean(property.parent))
            {
               parent = property.parent;
            }
            else
            {
               parent = basicParent;
            }
            switch(cla)
            {
               case Button:
                  text = Boolean(property.text) ? property.text : "";
                  style = Boolean(property.style) ? property.style : "Button_Close";
                  dm = infoArr[2];
                  delete property.text;
                  delete property.style;
                  obj = ComponentUtil.getButton(text,style,parent,property,dm);
                  break;
               case MyTextField:
                  text = Boolean(property.text) ? property.text : "";
                  delete property.text;
                  obj = ComponentUtil.getTextField(text,parent,property);
                  break;
               case TabButton:
                  text = Boolean(property.text) ? property.text : "";
                  tbStyle = Boolean(property.style) ? property.style : "TabButton_Four";
                  delete property.text;
                  delete property.style;
                  obj = ComponentUtil.getTabButton(text,tbStyle,parent,property);
                  break;
               case Bitmap:
                  obj = new Bitmap();
                  ComponentUtil.setPropertie(obj,property);
                  parent.addChild(obj as Bitmap);
                  if(Boolean(property.url))
                  {
                     Utils.getLoadBitmap(property.url,obj as Bitmap);
                  }
                  break;
               case RadioButton:
                  text = Boolean(property.text) ? property.text : "";
                  rbStyle = Boolean(property.style) ? property.style : "Button_Close";
                  delete property.text;
                  delete property.style;
                  obj = ComponentUtil.getRadioButton(text,rbStyle,parent,property,infoArr[2]);
                  if(parent is RadioButtonGroup == false)
                  {
                     parent.addChild(obj as RadioButton);
                  }
                  break;
               case Bitmap2:
                  obj = new Bitmap2();
                  ComponentUtil.setPropertie(obj,property);
                  parent.addChild(obj as Bitmap);
                  if(Boolean(property.url))
                  {
                     (obj as Bitmap2).load(property.url);
                  }
            }
         }
      }
   }
}

