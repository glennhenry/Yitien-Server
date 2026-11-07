package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_bangList_Item extends Sprite
   {
      
      private var Button_Check:Button;
      
      private var Button_Join:Button;
      
      public var Member_text:MyTextField;
      
      public var Lever_text:MyTextField;
      
      public var BangZhu_text:MyTextField;
      
      public var BangName_text:MyTextField;
      
      public var Rank_text:MyTextField;
      
      private var _str_bmp:DisplayObject;
      
      private var spr:Sprite;
      
      private var _select:Boolean;
      
      public var partyId:Number;
      
      public var _members:int;
      
      public var isBang:Boolean = true;
      
      public var isBang_full:Boolean = true;
      
      public function View_bangList_Item()
      {
         super();
         this.init();
         addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
      }
      
      public function init() : void
      {
         this._str_bmp = ComponentUtil.getDisplayObject("Item_Select",this,{
            "width":646,
            "height":26,
            "y":-3
         });
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":24,
            "width":650,
            "height":2
         },Global.Img_Cdm);
         this.spr = new Sprite();
         addChild(this.spr);
         this.spr.graphics.beginFill(0,0);
         this.spr.graphics.drawRect(0,0,650,24);
         this.spr.graphics.endFill();
         this.spr.mouseChildren = false;
         this.spr.mouseEnabled = false;
         (this._str_bmp as Sprite).mouseEnabled = false;
         (this._str_bmp as Sprite).mouseChildren = false;
         this._str_bmp.visible = false;
         this.Button_Check = ComponentUtil.getButton(LangConfig.getWord("50029",5),"Button_Two",this,{
            "x":538,
            "y":0,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Join = ComponentUtil.getButton(LangConfig.getWord("50030",5),"Button_Two",this,{
            "x":595,
            "y":0,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Rank_text = ComponentUtil.getTextField("000",this,{
            "x":8,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":25
         });
         this.BangName_text = ComponentUtil.getTextField("",this,{
            "x":87,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":111
         });
         this.BangZhu_text = ComponentUtil.getTextField("",this,{
            "x":217,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":126
         });
         this.Lever_text = ComponentUtil.getTextField("0000",this,{
            "x":347,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":102
         });
         this.Member_text = ComponentUtil.getTextField("000/000",this,{
            "x":433,
            "y":3,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":144
         });
         this.Member_text.autoSize = TextFieldAutoSize.CENTER;
         this.Lever_text.autoSize = TextFieldAutoSize.CENTER;
         this.BangZhu_text.autoSize = TextFieldAutoSize.CENTER;
         this.BangName_text.autoSize = TextFieldAutoSize.CENTER;
         this.BangName_text.align = TextAlign.CENTER;
         this.BangZhu_text.align = TextAlign.CENTER;
         this.Lever_text.align = TextAlign.CENTER;
         this.Member_text.align = TextAlign.CENTER;
         this.Rank_text.autoSize = TextFieldAutoSize.CENTER;
         var tf:TextFormat = new TextFormat();
         tf.align = TextAlign.CENTER;
         this.BangZhu_text.setTextFormat(tf);
         this.BangName_text.setTextFormat(tf);
         this.Rank_text.setTextFormat(tf);
         this.Button_Check.callBack = this.checkHandle;
         this.Button_Check.addEventListener(MouseEvent.MOUSE_DOWN,this.check_down_Handle);
         this.Button_Join.callBack = this.applyBangkHandle;
      }
      
      private function check_down_Handle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         this._str_bmp.visible = true;
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         if(!this._select)
         {
            this._str_bmp.visible = false;
         }
      }
      
      public function set select(value:Boolean) : void
      {
         this._select = value;
         this._str_bmp.visible = value;
      }
      
      public function checkHandle(e:MouseEvent) : void
      {
         BangCGMessage.CG_BANG_CHECK(this.partyId);
      }
      
      public function applyBangkHandle(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("50031",5));
            return;
         }
         BangCGMessage.CG_BANG_APPLY(this.partyId);
      }
      
      public function set members(_n:int) : void
      {
         this._members = _n;
         this.Member_text.text = String(_n) + "/" + "100";
      }
   }
}

