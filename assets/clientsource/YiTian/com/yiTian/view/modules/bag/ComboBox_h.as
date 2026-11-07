package com.yiTian.view.modules.bag
{
   import com.event.TextField_h;
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class ComboBox_h extends Sprite
   {
      
      private static const GAP_HEIGHT:int = 5;
      
      private var dis_over:DisplayObject;
      
      private var btn:Button;
      
      private var dis_bgList:DisplayObject;
      
      private var tf_now:TextField_h;
      
      private var vec_tf_list:Vector.<TextField_h>;
      
      private var _callBack:Function;
      
      private var com_width:int;
      
      private var bListVisible:Boolean;
      
      private var str_Default:String;
      
      public function ComboBox_h()
      {
         super();
         this.bListVisible = false;
         this.vec_tf_list = new Vector.<TextField_h>();
      }
      
      public function Init(vec:Vector.<String>, $com_width:int, $str_Default:String = "", str_over:String = "ButtonListBG_up", str_bgList:String = "ComboBox_background", str_btn:String = "Button_PageDown") : void
      {
         this.str_Default = $str_Default;
         this.com_width = $com_width;
         this.btn = ComponentUtil.getButton("",str_btn,this,null,Global.Img_Cdm);
         this.btn.x = this.com_width - this.btn.width;
         this.dis_bgList = ComponentUtil.getDisplayObject(str_bgList,this);
         this.dis_bgList.width = this.com_width;
         this.dis_bgList.y = this.btn.height;
         this.btn.addEventListener(MouseEvent.CLICK,this.CLICK);
         if(Boolean(str_over))
         {
            this.dis_over = ComponentUtil.getDisplayObject(str_over,this);
            this.dis_over.width = this.com_width;
         }
         this.createList(vec);
         this.tf_now = new TextField_h();
         addChild(this.tf_now);
         this.tf_now.text = this.str_Default;
         this.dis_bgList.visible = false;
         if(Boolean(this.dis_over))
         {
            this.dis_over.visible = false;
         }
         var i:int = 0;
         while(i < this.vec_tf_list.length)
         {
            this.vec_tf_list[i].visible = false;
            i++;
         }
      }
      
      public function set callBack(value:Function) : void
      {
         this._callBack = value;
      }
      
      public function setDefault(id:int) : void
      {
         var i:int = 0;
         if(id == -1)
         {
            this.bListVisible = false;
            this.tf_now.text = this.str_Default;
            this.dis_bgList.visible = false;
            if(Boolean(this.dis_over))
            {
               this.dis_over.visible = false;
            }
            i = 0;
            while(i < this.vec_tf_list.length)
            {
               this.vec_tf_list[i].visible = false;
               i++;
            }
         }
         else
         {
            this.tf_now.htmlText = this.vec_tf_list[id].htmlText;
            this._callBack(id);
         }
      }
      
      private function createList(vec:Vector.<String>) : void
      {
         var str:String = null;
         var tf:TextField_h = null;
         var i:int = 0;
         if(Boolean(this.dis_over))
         {
            i = 0;
            while(i < vec.length)
            {
               tf = new TextField_h();
               addChild(tf);
               tf.tabIndex = i;
               tf.mouseEnabled = true;
               tf.selectable = false;
               tf.addEventListener(TextEvent.LINK,this.LINK);
               str = HtmlUtil.createLink(vec[i],false);
               tf.htmlText = str;
               tf.y = i * (tf.textHeight + GAP_HEIGHT) + this.btn.height;
               this.vec_tf_list.push(tf);
               tf.addEventListener(MouseEvent.ROLL_OVER,this.ROLL_OVER);
               tf.addEventListener(MouseEvent.ROLL_OUT,this.ROLL_OUT);
               i++;
            }
            this.dis_over.height = this.vec_tf_list[0].textHeight + GAP_HEIGHT;
         }
         else
         {
            i = 0;
            while(i < vec.length)
            {
               tf = new TextField_h();
               addChild(tf);
               tf.tabIndex = i;
               tf.mouseEnabled = true;
               tf.selectable = false;
               tf.addEventListener(TextEvent.LINK,this.LINK);
               str = HtmlUtil.createLink(vec[i],false);
               tf.htmlText = str;
               tf.y = i * (tf.textHeight + GAP_HEIGHT) + this.btn.height;
               this.vec_tf_list.push(tf);
               i++;
            }
         }
         this.dis_bgList.height = this.vec_tf_list[this.vec_tf_list.length - 1].y - this.vec_tf_list[0].y + this.vec_tf_list[0].textHeight + GAP_HEIGHT;
      }
      
      private function showList() : void
      {
         var i:int = 0;
         this.bListVisible = !this.bListVisible;
         if(this.bListVisible)
         {
            this.dis_bgList.visible = true;
            i = 0;
            while(i < this.vec_tf_list.length)
            {
               this.vec_tf_list[i].visible = true;
               i++;
            }
         }
         else
         {
            this.dis_bgList.visible = false;
            if(Boolean(this.dis_over))
            {
               this.dis_over.visible = false;
            }
            i = 0;
            while(i < this.vec_tf_list.length)
            {
               this.vec_tf_list[i].visible = false;
               i++;
            }
         }
      }
      
      private function CLICK(event:MouseEvent) : void
      {
         this.showList();
      }
      
      private function LINK(e:TextEvent) : void
      {
         this.showList();
         var id:int = (e.target as TextField_h).tabIndex;
         this.tf_now.htmlText = this.vec_tf_list[id].htmlText;
         this._callBack(id);
         e.stopPropagation();
      }
      
      private function ROLL_OUT(e:MouseEvent) : void
      {
         this.dis_over.visible = false;
         e.stopPropagation();
      }
      
      private function ROLL_OVER(e:MouseEvent) : void
      {
         this.dis_over.y = e.target.y;
         this.dis_over.visible = true;
         e.stopPropagation();
      }
   }
}

