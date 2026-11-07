package com.yiTian.view.modules.actions
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class JJDanTips extends Panel
   {
      
      private static const infoStr:String = "使用{0}后可获得{1}倍打怪经验";
      
      private static const infoStrBuy:String = "背包内无经验丹，立刻去秘境购买";
      
      private var tf_info:MyTextField;
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      private var _okCB:Function;
      
      private var bg:DisplayObject;
      
      private var checkBox:CheckBox;
      
      private var grid:View_Grid;
      
      private var nameTf:MyTextField;
      
      private var __checkArr:Array = [0,0];
      
      private var __type:int;
      
      private var __gridId:int;
      
      private var __vo:Vo_item;
      
      public function JJDanTips()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         bindParent = GameScene.sysLayer;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,308,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "x":60,
            "y":87,
            "color":16184781,
            "realWidth":188,
            "size":12,
            "bold":false
         });
         this.tf_info.htmlText = LangConfig.getWord("29114",2);
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         addChild(this.grid);
         ComponentUtil.setPropertie(this.grid,{
            "x":120 - 15,
            "y":51
         });
         this.nameTf = ComponentUtil.getTextField("特级经验丹",this,{
            "x":120 + 25,
            "y":61,
            "size":12,
            "bold":false
         });
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Orange",this,{
            "x":55,
            "y":152,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":175,
            "y":152,
            "textColor":16184781
         },Global.Img_Cdm);
         this.checkBox = ComponentUtil.getCheckBox(LangConfig.getWord("29115",2),"CheckBox01",this,{
            "x":120,
            "y":112
         },Global.Img_Cdm);
         this.checkBox.clickFun = function(e:CheckBox):void
         {
            if(e.selected)
            {
               __checkArr[__type] = 1;
            }
            else
            {
               __checkArr[__type] = 0;
            }
         };
      }
      
      override protected function initDynamicView() : void
      {
         this.btn_ok.callBack = this.okClick;
         this.btn_cancel.callBack = this.hide;
         CloseButton.callBack = this.hide;
      }
      
      private function handle(_gridId:int, _id:int) : void
      {
         var vo:Vo_item = null;
         var addExp:Number = NaN;
         var color:String = null;
         var _infoStr:String = null;
         if(_gridId != 0)
         {
            vo = new Vo_item();
            vo.id = _id;
            vo.Init_lib();
            vo.gridId = _gridId;
            this.grid.vo = vo;
            this.__vo = vo;
            addExp = 1 + 0.25 * vo.color;
            this.grid.visible = true;
            this.nameTf.visible = true;
            this.tf_info.y = 100;
            this.checkBox.y = 126;
            color = Model_shop.get_color_arr[vo.color - 1];
            _infoStr = infoStr.replace("{0}",HtmlUtil.font(vo.str_name,color)).replace("{1}",HtmlUtil.font(addExp.toString(),color));
            this.nameTf.htmlText = HtmlUtil.font(vo.str_name,color);
            this.tf_info.htmlText = _infoStr;
            this.btn_cancel.visible = false;
            this.btn_ok.x = 110;
            this.btn_ok.label = "立即使用";
            this.__type = 1;
         }
         else
         {
            this.grid.visible = false;
            this.nameTf.visible = false;
            this.tf_info.y = 67;
            this.checkBox.y = 112;
            this.tf_info.htmlText = infoStrBuy;
            this.btn_cancel.visible = true;
            this.btn_ok.x = 55;
            this.btn_ok.label = "秘境购买";
            this.__type = 0;
         }
      }
      
      public function show(okCB:Function, gridId:int, _id:int) : void
      {
         this.__gridId = gridId;
         this.handle(gridId,_id);
         this.checkBox.selected = this.__checkArr[this.__type] == 1;
         if(this.__checkArr[this.__type] == 1)
         {
            if(Boolean(okCB.length))
            {
               okCB(this.__type,this.__vo);
            }
            else
            {
               okCB();
            }
            return;
         }
         this._okCB = okCB;
         this.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 308) / 2;
         y = (Global.stage.stageHeight - 186) / 2;
      }
      
      private function okClick(evt:MouseEvent) : void
      {
         if(this._okCB != null)
         {
            if(Boolean(this._okCB.length))
            {
               this._okCB(this.__type,this.__vo);
            }
            else
            {
               this._okCB();
            }
         }
         if(this.__type == 0)
         {
            UIManager.special_btn.smsHandle();
         }
         else if(this.__type == 1)
         {
            UIManager.heroHead.buffItemUse(this.__vo,1);
         }
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            this._okCB = null;
         }
         super.visible = value;
      }
      
      public function hide(e:MouseEvent = null) : void
      {
         this.visible = false;
         this.checkBox.selected = false;
      }
   }
}

