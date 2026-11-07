package com.yiTian.view.modules.WulinDaHui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.modules.roleHead.BuffterVO;
   import com.yiTian.view.modules.roleHead.BuffterView;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class View_WulinRecord extends UIBase
   {
      
      public static var canBattle:Boolean = false;
      
      private var t1:MyTextField;
      
      private var t2:MyTextField;
      
      private var t3:MyTextField;
      
      private var t4:MyTextField;
      
      private var t5:MyTextField;
      
      private var t6:MyTextField;
      
      private var title:MyTextField;
      
      private var HD_Check:Button;
      
      private var bmp:Bitmap;
      
      private var freshTime:int;
      
      private var _partyTime:int;
      
      private var _last:int;
      
      private var _now:int;
      
      private const bufferXY:Point = new Point(74,90);
      
      private var buffterVec:Vector.<BuffterView> = new Vector.<BuffterView>();
      
      public function View_WulinRecord()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         GameScene.downUILayer.addChild(this);
         ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this,{
            "x":0,
            "y":0,
            "width":290,
            "height":166
         },Global.Img_Cdm);
         this.HD_Check = ComponentUtil.getButton("","Button_HDSeach",this,{
            "x":30,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_HDTips",this,{
            "x":236,
            "y":2,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               trace("----");
            }
         },Global.Img_Cdm);
         TipManager.bind(this.HD_Check,LangConfig.getWord("884",0));
         this.HD_Check.callBack = this.openPaiHang;
         this.title = ComponentUtil.getTextField(LangConfig.getWord("885",0),this,{
            "x":121.9,
            "y":5,
            "textColor":16776960
         });
         this.t1 = ComponentUtil.getTextField(LangConfig.getWord("886",0),this,{
            "x":35,
            "y":25 + 3,
            "color":16755712
         });
         this.t2 = ComponentUtil.getTextField(LangConfig.getWord("887",0),this,{
            "x":35,
            "y":47 + 3,
            "color":16755712
         });
         this.t3 = ComponentUtil.getTextField(LangConfig.getWord("888",0),this,{
            "x":35,
            "y":69 + 3,
            "color":16755712
         });
         this.t4 = ComponentUtil.getTextField(LangConfig.getWord("889",0),this,{
            "x":35,
            "y":91 + 3,
            "color":16755712
         });
         this.t5 = ComponentUtil.getTextField(LangConfig.getWord("890",0),this,{
            "x":35,
            "y":113 + 3,
            "color":16755712
         });
         this.t6 = ComponentUtil.getTextField(LangConfig.getWord("891",0),this,{
            "x":35,
            "y":135 + 3,
            "color":16449280
         });
         this.visible = false;
      }
      
      private function openPaiHang(e:MouseEvent) : void
      {
         UIManager.wulin_paihang.visible = !UIManager.wulin_paihang.visible;
      }
      
      public function getData(partyTime:int, lifeRemain:int, score:int, itemTimeCount:int, DeadCount:int) : void
      {
         this.t1.text = LangConfig.getWord("886",0) + DateUtil.getMSBySecond3(50 * 60);
         this.t2.text = LangConfig.getWord("887",0) + String(lifeRemain);
         this.t3.text = LangConfig.getWord("888",0) + String(score);
         this.t4.text = LangConfig.getWord("889",0);
         this.t5.text = LangConfig.getWord("890",0) + DateUtil.getMSBySecond3(5 * 60);
         this.t6.text = LangConfig.getWord("891",0) + String(DeadCount);
         this.freshTime = 5 * 60;
         this._partyTime = 50 * 60;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            GameScene.instance.removeFrameCallBack(this.frameHandle);
         }
      }
      
      public function startCount() : void
      {
         GameScene.instance.addFrameCallBack(this.frameHandle);
      }
      
      public function updata(leftLife:int, scores:int) : void
      {
         this.t2.text = LangConfig.getWord("887",0) + String(leftLife);
         this.t3.text = LangConfig.getWord("888",0) + String(scores);
      }
      
      public function updataRefresh() : void
      {
         this.freshTime = 5 * 60;
      }
      
      private function frameHandle(instanc:int) : void
      {
         this._now = getTimer();
         if(this._now - this._last >= 1000)
         {
            --this.freshTime;
            --this._partyTime;
            if(this.freshTime < 0)
            {
               this.freshTime = 0;
            }
            this.t1.text = LangConfig.getWord("886",0) + DateUtil.getMSBySecond3(this._partyTime);
            this.t5.text = LangConfig.getWord("890",0) + DateUtil.getMSBySecond3(this.freshTime);
            this._last = this._now;
         }
      }
      
      public function showBuffter() : void
      {
         var buffVOVec:Vector.<Vo_Buffer> = BuffterVO.wuLinBuffVOVec;
         this.buffterVec.forEach(function(item:BuffterView, index:int, vec:Vector.<BuffterView>):void
         {
            item.visible = false;
            item.dispose();
         });
         if(buffVOVec.length > 0)
         {
            buffVOVec.forEach(function(item:Vo_Buffer, index:int, vec:Vector.<Vo_Buffer>):void
            {
               try
               {
                  buffterVec[index].vo = item;
                  buffterVec[index].visible = true;
               }
               catch(e:Error)
               {
                  buffterVec[index] = new BuffterView();
                  buffterVec[index].vo = item;
                  addChild(buffterVec[index]);
                  buffterVec[index].x = bufferXY.x + (buffterVec[index].width + 10) * index + 20;
                  buffterVec[index].y = bufferXY.y;
               }
            });
         }
      }
      
      public function upTxt(_count:int) : void
      {
         this.t6.text = LangConfig.getWord("891",0) + String(_count);
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width + 25;
         y = 190 + 20;
      }
   }
}

