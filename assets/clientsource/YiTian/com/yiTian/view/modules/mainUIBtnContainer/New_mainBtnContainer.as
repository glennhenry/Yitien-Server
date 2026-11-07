package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.modules.QT.View_qtPanel;
   import com.yiTian.view.modules.actions.frids.NewFriendTip;
   import com.yiTian.view.modules.bianqiangzhiyin.View_bqzy;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class New_mainBtnContainer extends MainUIBase
   {
      
      public static var isUsingNewBtn:Boolean = true;
      
      public static var isShowBtn:Boolean = true;
      
      private var btnArr:Array = [];
      
      private var maskSpr:Sprite;
      
      private var contanerBtn:Sprite = new Sprite();
      
      private const btnW:int = 44;
      
      private const btnW_gap:int = 3;
      
      private const btnH:int = 45;
      
      private var hideBtn:Button;
      
      private var showBtn:Button;
      
      public function New_mainBtnContainer()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         if(!isUsingNewBtn)
         {
            return;
         }
         this.maskSpr = new Sprite();
         this.maskSpr.graphics.beginFill(0,1);
         this.maskSpr.graphics.drawRect(0,0,Global.stage.stageWidth,80);
         this.maskSpr.graphics.endFill();
         addChild(this.maskSpr);
         bindParent = GameScene.uiLayer;
         addChild(this.contanerBtn);
         this.contanerBtn.mask = this.maskSpr;
         this.showBtn = ComponentUtil.getButton("","Button_XTBKZ",this.contanerBtn,{"textColor":16771436},Global.Img_Cdm);
         this.hideBtn = ComponentUtil.getButton("","Button_XTBSS",this.contanerBtn,{"textColor":16771436},Global.Img_Cdm);
         this.showBtn.callBack = this.onShowBtn;
         this.hideBtn.callBack = this.onHideBtn;
         this.showBtn.x = -this.showBtn.width;
         visible = true;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      private function onShowBtn(e:MouseEvent) : void
      {
         var targetX:int = 0;
         isShowBtn = true;
         if(this.btnArr.length > 4)
         {
            targetX = Global.stage.stageWidth - this.contanerBtn.width + this.btnW * 2;
         }
         else
         {
            targetX = Global.stage.stageWidth - this.contanerBtn.width + this.btnW;
         }
         Tween.to(this.contanerBtn,400,{"x":[this.contanerBtn.x,targetX]},this.resetPositionBtn);
      }
      
      private function onHideBtn(e:MouseEvent) : void
      {
         isShowBtn = false;
         Tween.to(this.contanerBtn,400,{"x":[this.contanerBtn.x,Global.stage.stageWidth]},this.resetPositionBtn);
      }
      
      public function addBtn(displayObj:DisplayObject) : void
      {
         var index:int = 0;
         if(this.hasBtn(displayObj))
         {
            return;
         }
         this.btnArr.push(displayObj);
         index = this.btnArr.indexOf(NewFriendTip.btn);
         if(index != -1)
         {
            this.btnArr.unshift(this.btnArr.splice(index,1)[0]);
         }
         index = this.btnArr.indexOf(View_qtPanel.instance.icon);
         if(index != -1)
         {
            this.btnArr.push(this.btnArr.splice(index,1)[0]);
         }
         displayObj.addEventListener(MouseEvent.MOUSE_OVER,this.btnOnMouseOver);
         displayObj.addEventListener(MouseEvent.MOUSE_OUT,this.btnOnMouseOut);
         this.contanerBtn.addChild(displayObj);
         addEventListener(Event.EXIT_FRAME,this.resetPositionBtn);
      }
      
      private function resetPositionBtn(e:*) : void
      {
         var _w:int = 0;
         var b:DisplayObject = null;
         removeEventListener(Event.EXIT_FRAME,this.resetPositionBtn);
         _w = 0;
         var i:int = 0;
         while(i < this.btnArr.length)
         {
            b = this.btnArr[i];
            b.x = _w;
            _w += this.btnW + this.btnW_gap;
            i++;
         }
         this.hideBtn.x = _w;
         if(isShowBtn)
         {
            this.showBtn.visible = false;
            if(this.btnArr.length > 4)
            {
               this.hideBtn.visible = false;
               this.contanerBtn.x = Global.stage.stageWidth - this.contanerBtn.width + this.btnW * 2;
            }
            else
            {
               this.hideBtn.visible = true;
               this.contanerBtn.x = Global.stage.stageWidth - this.contanerBtn.width + this.btnW;
            }
         }
         else
         {
            this.showBtn.visible = true;
            this.contanerBtn.x = Global.stage.stageWidth;
         }
      }
      
      public function btnOnMouseOver(e:Event) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorWhite2;
      }
      
      public function btnOnMouseOut(e:Event) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
      }
      
      public function removeBtn(displayObj:DisplayObject) : void
      {
         var b:DisplayObject = null;
         if(Boolean(this.btnArr.length))
         {
            for each(b in this.btnArr)
            {
               if(displayObj == b)
               {
                  this.contanerBtn.removeChild(b);
                  this.btnArr.splice(this.btnArr.indexOf(displayObj),1);
               }
            }
         }
         addEventListener(Event.EXIT_FRAME,this.resetPositionBtn);
      }
      
      public function hasBtn(btn:DisplayObject) : Boolean
      {
         var b:DisplayObject = null;
         if(Boolean(this.btnArr.length))
         {
            for each(b in this.btnArr)
            {
               if(btn == b)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function resetPosition() : void
      {
         x = BoatManager.newBtnCX;
         y = 380;
         if(Boolean(UIManager.questTraceView) && Boolean(UIManager.questTraceView.newerGuideUnit) && UIManager.questTraceView.newerGuideUnit.visible)
         {
            y = 380 + 45 + View_bqzy.thisH + 10;
         }
         else
         {
            y = 380 + View_bqzy.thisH;
         }
         this.maskSpr.width = Global.stage.stageWidth;
         addEventListener(Event.EXIT_FRAME,this.resetPositionBtn);
      }
   }
}

