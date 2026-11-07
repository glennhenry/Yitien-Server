package com.yiTian.view.modules.test
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.TextInput;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MTxt extends Sprite
   {
      
      private var tf1:MyTextField;
      
      private var tf2:MyTextField;
      
      private var tf3:TextInput;
      
      private var tf4:MyTextField;
      
      private var _index:int;
      
      private var _type:String;
      
      public function MTxt()
      {
         super();
         this.tf1 = ComponentUtil.getTextField("参数",this,{
            "x":2,
            "y":3,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.tf2 = ComponentUtil.getTextField("删除",this,{
            "x":40,
            "y":3,
            "color":16383744,
            "size":12,
            "leading":0,
            "underline":true
         });
         this.tf4 = ComponentUtil.getTextField("类型",this,{
            "x":69,
            "y":3,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.tf2.mouseEnabled = true;
         ComponentUtil.getScaleBitmap("Back2",[2,2,15,15],this,{
            "x":104,
            "y":2,
            "width":55,
            "height":20
         },Global.Img_Cdm);
         this.tf3 = ComponentUtil.getTextInput("输入参数","TextInput1",this,{
            "x":105,
            "y":1,
            "BackgroundColor":65280
         });
         this.tf3.addEventListener(MouseEvent.CLICK,this.onClick);
         this.tf2.addEventListener(MouseEvent.CLICK,this.onDel);
      }
      
      protected function onDel(event:MouseEvent) : void
      {
         Global.control.sendNotification("删除参数",this._index);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         this.tf3.text = "";
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set type(value:String) : void
      {
         this._type = value;
         this.tf4.text = value;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
         this.tf1.text = "参数" + this._index;
      }
      
      public function get text() : String
      {
         return this.tf3.text;
      }
   }
}

