package com.yiTian.view.modules.panel
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.ControlPan;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.modules.bag.View_panel;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.role.RolePanelTip;
   import com.yiTian.view.modules.role.View_role_base;
   import com.yiTian.view.modules.role.View_role_equip;
   import com.yiTian.view.modules.role.View_role_fashionShow;
   import com.yiTian.view.modules.role.View_role_meridian;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_rolePanel extends View_panel
   {
      
      private static const INDEX:int = 45;
      
      private static const COUNT:int = 3;
      
      private var ARR_STR:Array;
      
      public var vec_view:Vector.<DisplayObject>;
      
      private var view_now:DisplayObject;
      
      private var tbtn_now:TabButton;
      
      private var vec_tbtn:Vector.<TabButton>;
      
      public var view_role_equip:View_role_equip;
      
      public var view_role_meridian:View_role_meridian;
      
      public var view_role_fashionShow:View_role_fashionShow;
      
      private var back:DisplayObject;
      
      private var _title:Sprite;
      
      private var _tip:RolePanelTip;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_rolePanel()
      {
         super();
      }
      
      public function get tip() : RolePanelTip
      {
         if(!this._tip)
         {
            this._tip = new RolePanelTip();
         }
         return this._tip;
      }
      
      override protected function initStaticView() : void
      {
         var tbtn:TabButton = null;
         var v:DisplayObject = null;
         this.ARR_STR = [LangConfig.getWord("10623",1),LangConfig.getWord("10624",1),LangConfig.getWord("29455",2)];
         isTween = true;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":474,
            "height":472
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":426,
            "height":422
         },Global.Img_Cdm);
         this._title = new Sprite();
         this.addChild(this._title);
         move = new Rectangle(0,0,445,36);
         btn_close = ComponentUtil.getButton("","Button_Close",this,{
            "x":440,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         addEventListener_close();
         this.vec_tbtn = new Vector.<TabButton>(COUNT,true);
         this.vec_view = new Vector.<DisplayObject>(COUNT,true);
         var i:int = 0;
         while(i < COUNT)
         {
            switch(i)
            {
               case Enum_panel_role.EQUIP:
                  v = this.view_role_equip = new View_role_equip();
                  break;
               case Enum_panel_role.MERIDIAN:
                  v = this.view_role_meridian = new View_role_meridian();
                  break;
               case Enum_panel_role.FASHIONSHOW:
                  v = this.view_role_fashionShow = new View_role_fashionShow();
            }
            addChild(v);
            v.visible = false;
            if(v is View_role_base)
            {
               (v as View_role_base).Init();
            }
            this.vec_view[i] = v;
            i++;
         }
         i = 0;
         while(i < COUNT)
         {
            tbtn = ComponentUtil.getTabButton(this.ARR_STR[i],"TabButton_Four",this,{
               "x":38 + i * 80,
               "y":46,
               "textColor":16773818,
               "chooseColor":16773818
            },Global.Img_Cdm);
            tbtn.addEventListener(MouseEvent.CLICK,this.CLICK_TBTN);
            tbtn.tabIndex = i;
            this.vec_tbtn[i] = tbtn;
            i++;
         }
      }
      
      override public function get width() : Number
      {
         return this.back.width;
      }
      
      override public function get height() : Number
      {
         return this.back.height;
      }
      
      override protected function initDynamicView() : void
      {
         this.view_now = this.vec_view[Enum_panel_role.EQUIP];
         this.tbtn_now = this.vec_tbtn[Enum_panel_role.EQUIP];
      }
      
      override public function resetPosition() : void
      {
         var xp:Number = NaN;
         var yp:Number = NaN;
         if(UIManager.bagPanel.vsb)
         {
            xp = (Global.stage.stageWidth - (this.width + 10 + UIManager.bagPanel.width)) / 2;
            yp = (Global.stage.stageHeight - UIManager.rolePanel.height) / 2;
            Tween.to(UIManager.bagPanel,100,{
               "x":[UIManager.bagPanel.x,xp + this.width + 10],
               "y":[UIManager.bagPanel.y,yp]
            });
            x = xp;
            y = yp;
         }
         else
         {
            x = (Global.stage.stageWidth - this.width) / 2;
            y = (Global.stage.stageHeight - this.height) / 2;
         }
      }
      
      public function openView(enum_panel_role:int) : void
      {
         this.visible = true;
         this.view_now.visible = true;
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.showView(enum_panel_role);
         });
         if(this.tbtn_now.tabIndex != enum_panel_role)
         {
            this.view_now.visible = false;
            this.view_now = this.vec_view[enum_panel_role];
            this.view_now.visible = true;
            this.tbtn_now.choose = false;
            this.tbtn_now = this.vec_tbtn[enum_panel_role];
            this.tbtn_now.choose = true;
         }
      }
      
      private function CLICK_TBTN(e:MouseEvent) : void
      {
         var tbtn:TabButton = null;
         if(this.tbtn_now == tbtn)
         {
            return;
         }
         tbtn = e.target as TabButton;
         if(this.tbtn_now != null)
         {
            this.tbtn_now.choose = false;
         }
         tbtn.choose = true;
         this.tbtn_now = tbtn;
         this.view_now.visible = false;
         this.view_now = this.vec_view[tbtn.tabIndex];
         this.view_now.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         this.view_now.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               Utils.loadTitle("lang/ch/Role_Imgs.swf","Title_Role",new Bitmap(),{
                  "x":157,
                  "y":5
               },this._title);
               this.isFirstOpen = false;
               this.vec_tbtn[0].choose = true;
               bind_target = Enum_explor.bind(Enum_explor.BTN_ROLE);
            }
            ControlPan.dic_panel[ControlPan.ROLE] = this;
         }
         else
         {
            ControlPan.dic_panel[ControlPan.ROLE] = null;
         }
         ControlPan.panelControl(this);
      }
   }
}

