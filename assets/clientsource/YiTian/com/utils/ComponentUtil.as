package com.utils
{
   import com.event.Button_h;
   import com.event.TabButton_h;
   import com.event.TextField_h;
   import com.ui.containers.list.List;
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.ComboBox;
   import com.ui.controls.IconButton;
   import com.ui.controls.MyTextField;
   import com.ui.controls.RadioButton;
   import com.ui.controls.RadioButtonGroup;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.ui.controls.TextInput;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class ComponentUtil
   {
      
      public static var domain:ApplicationDomain;
      
      private static var dmDic:Dictionary = new Dictionary();
      
      public function ComponentUtil()
      {
         super();
      }
      
      public static function getShape(width:int, height:int, color:int = 16777215, alpha:Number = 1) : Shape
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(color,alpha);
         shape.graphics.drawRect(0,0,width,height);
         shape.graphics.endFill();
         return shape;
      }
      
      public static function getHeart(size:Number = 15) : Shape
      {
         var angle:Number = NaN;
         var dist:Number = NaN;
         var sin:Number = NaN;
         var cos:Number = NaN;
         var shape:Shape = new Shape();
         var heartSize:Number = size;
         var g:Graphics = shape.graphics;
         g.beginFill(16711680);
         g.moveTo(0 - heartSize,0);
         var i:uint = 1;
         while(i < 360)
         {
            angle = Math.PI * i / 180;
            sin = Math.sin(angle);
            cos = Math.cos(angle);
            dist = heartSize * (1 - sin);
            g.lineTo(0 - dist * cos,0 - dist * sin);
            i++;
         }
         g.endFill();
         return shape;
      }
      
      public static function getDisplayObject(url:String, parent:DisplayObjectContainer = null, property:Object = null, dm:ApplicationDomain = null) : DisplayObject
      {
         if(!dm)
         {
            dm = domain;
         }
         var cla:Class = dm.getDefinition(url) as Class;
         var disobj:DisplayObject = new cla();
         if(Boolean(property))
         {
            setPropertie(disobj,property);
         }
         disobj.cacheAsBitmap = true;
         if(Boolean(parent))
         {
            parent.addChild(disobj);
         }
         return disobj;
      }
      
      public static function getTextField(text:String, parent:DisplayObjectContainer = null, propertie:Object = null, autoSize:String = "left", type:String = "dynamic") : MyTextField
      {
         var textField:MyTextField = MyTextField.getTF();
         textField.autoSize = autoSize;
         textField.type = type;
         if(Boolean(propertie))
         {
            setPropertie(textField,propertie);
         }
         textField.text = text;
         if(Boolean(parent))
         {
            parent.addChild(textField);
         }
         return textField;
      }
      
      public static function getEmbedTF(text:String, parent:DisplayObjectContainer = null, propertie:Object = null) : MyTextField
      {
         var mtf:MyTextField = getTextField(text,parent,propertie);
         mtf.embedFonts = true;
         return mtf;
      }
      
      public static function getBitmap(url:String, parent:DisplayObjectContainer = null, propertie:Object = null, dm:ApplicationDomain = null) : Bitmap
      {
         var dic:Dictionary = null;
         var imges:Class = null;
         if(!dm)
         {
            dm = domain;
         }
         if(!dmDic[dm])
         {
            dmDic[dm] = new Dictionary();
         }
         var bitmap:Bitmap = new Bitmap();
         if(Boolean(url.length))
         {
            dic = dmDic[dm];
            if(!dic[url])
            {
               imges = dm.getDefinition(url) as Class;
               dic[url] = new imges(0,0);
            }
            bitmap.bitmapData = dic[url];
         }
         if(Boolean(propertie))
         {
            setPropertie(bitmap,propertie);
         }
         if(Boolean(parent))
         {
            parent.addChild(bitmap);
         }
         return bitmap;
      }
      
      public static function getScaleBitmap(url:String, arr:Array, parent:DisplayObjectContainer = null, propertie:Object = null, dm:ApplicationDomain = null) : ScaleBitmap
      {
         var scalebitmap:ScaleBitmap = null;
         var scalebitmapClass:Class = null;
         if(!dm)
         {
            dm = domain;
         }
         if(!dmDic[dm])
         {
            dmDic[dm] = new Dictionary();
         }
         Util.rect.x = arr[0];
         Util.rect.y = arr[1];
         Util.rect.width = arr[2];
         Util.rect.height = arr[3];
         var dic:Dictionary = dmDic[dm];
         if(!dic[url])
         {
            scalebitmapClass = dm.getDefinition(url) as Class;
            dic[url] = new scalebitmapClass(0,0);
         }
         scalebitmap = new ScaleBitmap(dic[url]);
         scalebitmap.setScale9Grid(Util.rect);
         if(Boolean(propertie))
         {
            setPropertie(scalebitmap,propertie);
         }
         if(Boolean(parent))
         {
            parent.addChild(scalebitmap);
         }
         return scalebitmap;
      }
      
      public static function getBitmapData(str:String, dm:ApplicationDomain = null) : BitmapData
      {
         var imges:Class = null;
         if(!dm)
         {
            dm = domain;
         }
         if(!dmDic[dm])
         {
            dmDic[dm] = new Dictionary();
         }
         var dic:Dictionary = dmDic[dm];
         if(!dic[str])
         {
            imges = dm.getDefinition(str) as Class;
            dic[str] = new imges(0,0);
         }
         return dic[str];
      }
      
      public static function getButton(text:String, style:String = null, parent:DisplayObjectContainer = null, property:Object = null, dm:ApplicationDomain = null) : Button
      {
         if(!dm)
         {
            dm = domain;
         }
         var btn:Button = new Button(text,style,dm);
         if(Boolean(property))
         {
            setPropertie(btn,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(btn);
         }
         return btn;
      }
      
      public static function getIconButton(text:String, style:String = null, parent:DisplayObjectContainer = null, property:Object = null, dm:ApplicationDomain = null) : IconButton
      {
         if(!dm)
         {
            dm = domain;
         }
         var iconBtn:IconButton = new IconButton(text,style,dm);
         if(Boolean(property))
         {
            setPropertie(iconBtn,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(iconBtn);
         }
         return iconBtn;
      }
      
      public static function getTextInput(defaultText:String, style:String = null, parent:DisplayObjectContainer = null, property:Object = null, size:int = 12, color:uint = 13434828, dm:ApplicationDomain = null) : TextInput
      {
         var textinput:TextInput = new TextInput(Boolean(property.width) ? int(property.width) : 100,Boolean(property.height) ? int(property.height) : 22,size,color,style,Boolean(dm) ? dm : domain);
         if(Boolean(property.x))
         {
            textinput.x = property.x;
         }
         if(Boolean(property.y))
         {
            textinput.y = property.y;
         }
         if(defaultText != null)
         {
            textinput.text = defaultText;
         }
         if(Boolean(parent))
         {
            parent.addChild(textinput);
         }
         return textinput;
      }
      
      public static function getTabButton(text:String, style:String, parent:DisplayObjectContainer = null, property:Object = null, dm:ApplicationDomain = null) : TabButton
      {
         if(!dm)
         {
            dm = domain;
         }
         var tabbtn:TabButton = new TabButton(text,style,dm);
         if(Boolean(property))
         {
            setPropertie(tabbtn,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(tabbtn);
         }
         return tabbtn;
      }
      
      public static function getList(wid:int, hei:int, itemClass:Class, parent:DisplayObjectContainer = null, property:Object = null, selFun:Function = null, nSelecFlag:int = 0, scrollDerect:String = "RIGHT") : List
      {
         var list:List = new List(wid,hei,itemClass,selFun,nSelecFlag,scrollDerect);
         if(Boolean(property))
         {
            setPropertie(list,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(list);
         }
         return list;
      }
      
      public static function setPropertie(object:*, propertie:Object) : void
      {
         var key:String = null;
         for(key in propertie)
         {
            object[key] = propertie[key];
         }
      }
      
      public static function getCheckBox(text:String, style:String, parent:DisplayObjectContainer = null, property:Object = null, dm:ApplicationDomain = null, selected:Boolean = false) : CheckBox
      {
         if(!dm)
         {
            dm = domain;
         }
         var checkbox:CheckBox = new CheckBox(text,style,dm,selected);
         if(Boolean(property))
         {
            setPropertie(checkbox,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(checkbox);
         }
         return checkbox;
      }
      
      public static function getRadioButton(text:String, style:String, parent:DisplayObjectContainer = null, property:Object = null, dm:ApplicationDomain = null, selected:Boolean = false) : RadioButton
      {
         if(!dm)
         {
            dm = domain;
         }
         var radioButton:RadioButton = new RadioButton(text,style,dm,selected);
         if(Boolean(property))
         {
            setPropertie(radioButton,property);
         }
         if(Boolean(parent) && parent is RadioButtonGroup)
         {
            (parent as RadioButtonGroup).addItem(radioButton);
         }
         return radioButton;
      }
      
      public static function getComboBox(sour:Array, dm:ApplicationDomain = null, _width:int = 90, _btnStyle:String = "xiala", _kuangStyle:String = "kuangBg", _overStyle:String = "xuanze_over", parent:DisplayObjectContainer = null, property:Object = null) : ComboBox
      {
         if(!dm)
         {
            dm = domain;
         }
         var comboBox:ComboBox = new ComboBox(sour,null,_width,_btnStyle,_kuangStyle,_overStyle);
         if(Boolean(property))
         {
            setPropertie(comboBox,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(comboBox);
         }
         return 0 as ComboBox;
      }
      
      public static function getButton_h(str_txt:String, str_url:String, bDisabled:Boolean, bOver:Boolean, bListen:Boolean, parent:DisplayObjectContainer = null, property:Object = null) : Button_h
      {
         var btn:Button_h = new Button_h();
         btn.Init(str_url,bDisabled,bOver,bListen);
         if(str_txt != "")
         {
            btn.Init_tf_label(str_txt);
         }
         if(Boolean(property))
         {
            setPropertie(btn,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(btn);
         }
         return btn;
      }
      
      public static function getTabButton_h(str_txt:String, str_url:String, bOver:Boolean, bListen:Boolean, parent:DisplayObjectContainer = null, property:Object = null) : TabButton_h
      {
         var btn:TabButton_h = new TabButton_h();
         btn.Init(str_url,bOver,bListen);
         if(str_txt != "")
         {
            btn.Init_tf_label(str_txt);
         }
         if(Boolean(property))
         {
            setPropertie(btn,property);
         }
         if(Boolean(parent))
         {
            parent.addChild(btn);
         }
         return btn;
      }
      
      public static function getTextField_h(text:String, parent:DisplayObjectContainer = null, propertie:Object = null, type:String = "dynamic") : TextField_h
      {
         var tf:TextField_h = new TextField_h(type);
         if(Boolean(propertie))
         {
            setPropertie(tf,propertie);
         }
         tf.htmlText = text;
         if(Boolean(parent))
         {
            parent.addChild(tf);
         }
         return tf;
      }
   }
}

