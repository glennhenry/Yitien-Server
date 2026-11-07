package com.yiTian.view.modules.qplus
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_lib_reward;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QplusShareCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.New_mainBtnContainer;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class ViewQplusShare extends Panel123
   {
      
      private var inviteFrendBtn:TabButton;
      
      private var shareBtn:TabButton;
      
      private var roundPoint:Bitmap;
      
      private var rouletteBtn:Button;
      
      private var blogBtn:TabButton;
      
      private var microBtn:TabButton;
      
      private var roundLen:int = 10;
      
      private var rouletteItem:Bitmap;
      
      private var rouletteItemArr:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var rouletteItemCoord:Array;
      
      private var getGiftId:int;
      
      private var getGiftNum:int;
      
      private var rouleBtnX:Number = 632;
      
      private var rouleBtnY:Number = 197;
      
      private var effEndP:Point;
      
      private var eff:Effect;
      
      private var rouletteNumTxt:MyTextField;
      
      private var isInitQplus:Boolean = false;
      
      private var inviteFirend:ViewInviteFirend;
      
      private var shareEvent:ViewShareEvent;
      
      private var microBlog:ViewMicroBlog;
      
      private var weixin:ViewWeixin;
      
      private var eleW:int = 33;
      
      private var eleH:int = 68;
      
      private var filterItem:Array = [new GlowFilter(16776960,1,10,8,5)];
      
      private var back:ScaleBitmap;
      
      private var round:Bitmap;
      
      private var micro:Bitmap;
      
      private var microBoo:Boolean = false;
      
      private var btn:MainUIBtn;
      
      private var btnEff:Effect;
      
      private var blogEff:Effect;
      
      private var microEff:Effect;
      
      private var rewardArr:Array = [4,1,5,6,2,9,7,8,3,10];
      
      private var hidBtn:Button;
      
      private var curTabBtn:TabButton;
      
      private var toPoint:Point;
      
      private var runing:Boolean = false;
      
      private var lastTime:int;
      
      private var change:Boolean = false;
      
      private var count:int = 0;
      
      private var tRunNum:int = 0;
      
      private var runCount:int = 0;
      
      private var totalTime:int;
      
      private var backItem:View_Grid;
      
      public function ViewQplusShare()
      {
         super();
      }
      
      private static function fly(eff:Sprite, fromPoint:Point, toPoint:Point) : void
      {
         Tween.to(eff,10 * 50,{
            "x":[fromPoint.x,toPoint.x],
            "y":[fromPoint.y,toPoint.y]
         });
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":882,
            "height":430
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":38,
            "width":833,
            "height":382
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":32,
            "y":68,
            "width":456,
            "height":344
         },Global.Img_Cdm);
         this.inviteFrendBtn = ComponentUtil.getTabButton(LangConfig.getWord("30089",3),"TabButton_Four",this,{
            "visible":false,
            "textColor":12232795,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.shareBtn = ComponentUtil.getTabButton(LangConfig.getWord("30090",3),"TabButton_Four",this,{
            "x":40,
            "y":47,
            "textColor":12232795,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.blogBtn = ComponentUtil.getTabButton(LangConfig.getWord("30108",3),"TabButton_Four",this,{
            "x":119,
            "y":46,
            "textColor":12232795,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.microBtn = ComponentUtil.getTabButton(LangConfig.getWord("30109",3),"TabButton_Four",this,{
            "x":200,
            "y":46,
            "textColor":12232795,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.rouletteItemCoord = [{
            "x":719,
            "y":116
         },{
            "x":759,
            "y":171
         },{
            "x":758,
            "y":239
         },{
            "x":717,
            "y":294
         },{
            "x":652,
            "y":314
         },{
            "x":587,
            "y":292
         },{
            "x":548,
            "y":237
         },{
            "x":549,
            "y":169
         },{
            "x":590,
            "y":115
         },{
            "x":654,
            "y":94
         }];
         this.rouletteNumTxt = ComponentUtil.getTextField(LangConfig.getWord("30091",3),this,{
            "x":748,
            "y":396,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":852,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         if(!this.isInitQplus)
         {
            SingleLoader.add("lang/ch/FengXiang_Imgs.swf",function(info:Object):void
            {
               Global.FengXiang_Imgsdm = info.applicationDomain;
               isInitQplus = true;
               initQplus();
            });
         }
         if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global._pf))
         {
            this.hidBtn = ComponentUtil.getButton("收藏游戏","Button_Four",this,{
               "x":760,
               "y":50
            },Global.Img_Cdm);
            this.hidBtn.callBack = function(e:MouseEvent):void
            {
               ExternalInterface.call("bookmark");
            };
         }
         this.initBtn();
         this.addQplusBtn();
      }
      
      private function initQplus() : void
      {
         var i:int = 0;
         var coordObj:Object = null;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var ve:Vo_equip = null;
         var arr:Array = null;
         ComponentUtil.getBitmap("Title_TGJieShao",this,{
            "x":346,
            "y":5
         },Global.FengXiang_Imgsdm);
         this.round = ComponentUtil.getBitmap("Round",this,{
            "x":499,
            "y":69
         },Global.FengXiang_Imgsdm);
         this.rouletteBtn = ComponentUtil.getButton("","Button_YaoJiang",this,{
            "x":this.rouleBtnX,
            "y":this.rouleBtnY,
            "textColor":16184781
         },Global.FengXiang_Imgsdm);
         this.effEndP = new Point(this.rouleBtnX + this.rouletteBtn.width / 2,this.rouleBtnY + this.rouletteBtn.height / 2);
         i = 0;
         while(i < this.roundLen)
         {
            coordObj = this.rouletteItemCoord[i] as Object;
            grid = new View_Grid();
            addChild(grid);
            this.rouletteItemArr.push(grid);
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_over();
            grid.set_tf_count();
            grid.set_bmp_bg();
            grid.x = coordObj.x + 3;
            grid.y = coordObj.y + 3 + 17;
            arr = Data_lib.rouletteReward[i + 1];
            if(arr[Enum_lib_reward.REWARDTYPE] == 1)
            {
               vo = new Vo_item();
               vo.id = arr[Enum_lib_reward.REWARDID];
               vo.count = arr[Enum_lib_reward.REWARDNUM];
               vo.Init_lib();
               grid.vo = vo;
               grid.set_bmp_select();
               TipManager.unBind(grid);
            }
            else
            {
               ve = new Vo_equip();
               ve.id = arr[Enum_lib_reward.REWARDID];
               ve.count = arr[Enum_lib_reward.REWARDNUM];
               ve.Init_lib();
               grid.vo = ve;
               grid.set_bmp_select();
               TipManager.unBind(grid);
            }
            i++;
         }
         this.inviteFirend = new ViewInviteFirend();
         addChild(this.inviteFirend);
         this.inviteFirend.x = this.eleW;
         this.inviteFirend.y = this.eleH;
         this.inviteFrendBtn.addEventListener(MouseEvent.CLICK,this.clkHandle);
         this.shareEvent = new ViewShareEvent();
         addChild(this.shareEvent);
         this.shareEvent.visible = false;
         this.shareEvent.x = this.eleW;
         this.shareEvent.y = this.eleH;
         this.shareBtn.addEventListener(MouseEvent.CLICK,this.clkHandle);
         this.shareBtn.choose = true;
         this.microBlog = new ViewMicroBlog();
         addChild(this.microBlog);
         this.microBlog.visible = false;
         this.microBlog.x = this.eleW;
         this.microBlog.y = this.eleH;
         this.blogBtn.addEventListener(MouseEvent.CLICK,this.clkHandle);
         this.weixin = new ViewWeixin();
         addChild(this.weixin);
         this.weixin.visible = false;
         this.weixin.x = this.eleW;
         this.weixin.y = this.eleH;
         this.microBtn.addEventListener(MouseEvent.CLICK,this.clkHandle);
         this.rouletteBtn.addEventListener(MouseEvent.CLICK,this.rouletteHandle);
         Global.control.registerCallBack(Enum_MsgType.QPLUS_SHARE_EFFTER,this.shareEffter);
         this.micro = ComponentUtil.getBitmap("ErWeiMa",this,{
            "x":499,
            "y":69
         },Global.FengXiang_Imgsdm);
         this.micro.visible = false;
         this.micro.width = 345;
         this.micro.height = 342;
      }
      
      private function showRound(boo:Boolean) : void
      {
         var i:int = 0;
         if(this.microBoo == !boo)
         {
            return;
         }
         this.microBoo = !boo;
         this.round.visible = boo;
         this.rouletteBtn.visible = boo;
         i = 0;
         while(i < this.roundLen)
         {
            View_Grid(this.rouletteItemArr[i]).visible = boo;
            i++;
         }
         this.micro.visible = !boo;
      }
      
      private function initBtn() : void
      {
         this.btn = new MainUIBtn("resource/image/exBtn/Icon_MRCJ.png");
         this.btn.addEventListener(MouseEvent.CLICK,this.clickBtnHandler);
      }
      
      public function get qplusBtn() : MainUIBtn
      {
         return this.btn;
      }
      
      public function addQplusBtn() : void
      {
         if(New_mainBtnContainer.isUsingNewBtn)
         {
            UIManager.newMainBtnContainer.addBtn(this.btn);
         }
         else
         {
            UIManager.mainUiBtnContainer.addBTN(this.btn);
         }
      }
      
      private function clickBtnHandler(evt:MouseEvent) : void
      {
         UIManager.qplusShare.visible = !UIManager.qplusShare.visible;
      }
      
      public function joinIconEff(value:Boolean) : void
      {
         if(value)
         {
            EffecObj.getEffec(this.btn);
         }
         else
         {
            EffecObj.removeEffect(this.btn);
         }
      }
      
      private function clkHandle(evt:MouseEvent) : void
      {
         var btn:TabButton = null;
         btn = evt.target as TabButton;
         if(this.curTabBtn == btn)
         {
            return;
         }
         if(Boolean(this.curTabBtn))
         {
            this.curTabBtn.choose = false;
         }
         btn.choose = true;
         this.curTabBtn = btn;
         this.inviteFirend.visible = false;
         this.shareEvent.visible = false;
         this.microBlog.visible = false;
         this.weixin.visible = false;
         if(btn.text == LangConfig.getWord("30089",3))
         {
            this.inviteFirend.visible = true;
            this.showRound(true);
         }
         else if(btn.text == LangConfig.getWord("30090",3))
         {
            this.shareEvent.visible = true;
            this.showRound(true);
         }
         else if(btn.text == LangConfig.getWord("30108",3))
         {
            if(Boolean(this.blogEff))
            {
               EffectManager.removeEffect(this.blogEff);
            }
            this.microBlog.visible = true;
            this.showRound(true);
         }
         else if(btn.text == LangConfig.getWord("30109",3))
         {
            if(Boolean(this.microEff))
            {
               EffectManager.removeEffect(this.microEff);
            }
            this.weixin.visible = true;
            this.showRound(false);
         }
      }
      
      private function shareEffter(p:Point) : void
      {
         var effContain:Sprite = null;
         p = this.globalToLocal(p);
         effContain = new Sprite();
         addChild(effContain);
         this.eff = EffectManager.addEffect("35120",effContain,800,-10,-10,true,3);
         effContain.x = p.x;
         effContain.y = p.y;
         this.toPoint = new Point(Number(744 + 20),Number(379 + 17 + 15));
         var t:Number = Math.atan((this.toPoint.y - p.y) / (this.toPoint.x - p.x)) * 180 / Math.PI;
         effContain.rotation = t;
         setTimeout(fly,7 * 50,effContain,p,this.toPoint);
         setTimeout(this.removeEff,18 * 50,effContain);
      }
      
      private function removeEff(mc:Sprite) : void
      {
         if(Boolean(this.eff) && mc.contains(this.eff))
         {
            mc.removeChild(this.eff);
            EffectManager.removeEffect(this.eff);
         }
         if(this.contains(mc))
         {
            this.removeChild(mc);
         }
         var txtEff:Effect = EffectManager.addEffect("35042",this,500,this.toPoint.x + 26,this.toPoint.y,true,3);
         setTimeout(this.removeTxtEff,500 * 3,txtEff);
      }
      
      private function removeTxtEff(curEff:Effect) : void
      {
         if(this.contains(curEff))
         {
            this.removeChild(curEff);
            EffectManager.removeEffect(curEff);
         }
      }
      
      private function rouletteHandle(evt:MouseEvent) : void
      {
         if(this.getGiftNum <= 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30092",3));
            return;
         }
         this.getGiftId = -1;
         this.runCount = 0;
         this.tRunNum = 0;
         this.runing = false;
         GameScene.instance.removeFrameCallBack(this.frameHandle);
         this.rouletteBtn.enabled = true;
         this.rouletteBtn.mouseEnabled = true;
         QplusShareCGMessage.CG_ROULETTE_ING();
      }
      
      private function frameHandle(value:int) : void
      {
         var curItem:View_Grid = null;
         var oldItem:View_Grid = null;
         if(!this.runing)
         {
            GameScene.instance.removeFrameCallBack(this.frameHandle);
            this.rouletteBtn.enabled = true;
            this.rouletteBtn.mouseEnabled = true;
         }
         this.rouletteBtn.enabled = false;
         this.rouletteBtn.mouseEnabled = false;
         if(getTimer() - this.lastTime > 30)
         {
            this.lastTime = getTimer();
            if(this.tRunNum > 0 && this.tRunNum <= this.roundLen)
            {
               oldItem = this.rouletteItemArr[this.tRunNum - 1] as View_Grid;
               oldItem.filters = null;
            }
            if(this.tRunNum >= this.roundLen)
            {
               ++this.runCount;
               this.tRunNum = 0;
            }
            curItem = this.rouletteItemArr[this.tRunNum] as View_Grid;
            this.change = !this.change;
            if(!this.change)
            {
               curItem.filters = this.filterItem;
            }
            else
            {
               curItem.filters = null;
            }
            this.getGifting();
            ++this.count;
            if(this.count % 2 == 0)
            {
               ++this.tRunNum;
            }
         }
      }
      
      private function getGifting() : void
      {
         if(this.runCount >= 2 && this.tRunNum == this.getGiftId && !this.change)
         {
            this.runCount = 0;
            this.tRunNum = 0;
            this.runing = false;
            GameScene.instance.removeFrameCallBack(this.frameHandle);
            if(this.getGiftNum > 0)
            {
               this.rouletteBtn.enabled = true;
               this.rouletteBtn.mouseEnabled = true;
            }
            else if(Boolean(this.btnEff))
            {
               EffectManager.removeEffect(this.btnEff);
            }
            this.flyGift();
         }
      }
      
      private function flyGift() : void
      {
         var lastItem:View_Grid = null;
         if(this.getGiftId >= 1)
         {
            lastItem = this.rouletteItemArr[int(this.getGiftId - 1)] as View_Grid;
         }
         else if(this.getGiftId == 0)
         {
            lastItem = this.rouletteItemArr[this.roundLen - 1] as View_Grid;
         }
         if(Boolean(lastItem))
         {
            lastItem.filters = null;
         }
         this.backItem = this.rouletteItemArr[this.getGiftId] as View_Grid;
         this.backItem.filters = this.filterItem;
         var strName:String = this.backItem.vo.str_name;
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("30101",3,strName));
         var coordObj:Object = this.rouletteItemCoord[this.getGiftId] as Object;
         var p:Point = new Point(coordObj.x + 3,coordObj.y + 3);
         p = localToGlobal(p);
         Tween.gridToBagBezierFuncDef(this.backItem,-1,p.x,p.y);
      }
      
      public function microActivty(t:int, f:int) : void
      {
         var dir:String = null;
         var px:Number = NaN;
         var py:Number = NaN;
         var _bx:Number = NaN;
         var _by:Number = NaN;
         var _mx:Number = NaN;
         var _my:Number = NaN;
         if(t == 0)
         {
            this.blogBtn.visible = false;
            this.microBtn.visible = false;
         }
         else if(t == 1)
         {
            this.blogBtn.visible = true;
            this.microBtn.visible = true;
         }
         if(f == 0)
         {
            if(Boolean(this.blogEff))
            {
               EffectManager.removeEffect(this.blogEff);
            }
            if(Boolean(this.microEff))
            {
               EffectManager.removeEffect(this.microEff);
            }
         }
         else if(f == 1)
         {
            if(this.blogBtn.visible)
            {
               dir = "35075";
               px = 37;
               py = 11;
               _bx = this.blogBtn.x;
               _by = this.blogBtn.y;
               _mx = this.microBtn.x;
               _my = this.microBtn.y;
               this.blogEff = EffectManager.addEffect(dir,this,1000,_bx + px,_by + py,true);
               this.microEff = EffectManager.addEffect(dir,this,1000,_mx + px,_my + py,true);
               addChild(this.blogEff);
               addChild(this.microEff);
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.shareBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            QplusShareCGMessage.CG_INVITE_QPLUS();
            if(Boolean(this.backItem))
            {
               this.backItem.filters = this.filterItem;
            }
         }
         else
         {
            if(Boolean(this.btnEff) && this.getGiftNum <= 0)
            {
               EffectManager.removeEffect(this.btnEff);
            }
            if(Boolean(this.blogEff))
            {
               EffectManager.removeEffect(this.blogEff);
            }
            if(Boolean(this.microEff))
            {
               EffectManager.removeEffect(this.microEff);
            }
         }
      }
      
      public function set rouletteNum(num:int) : void
      {
         this.rouletteNumTxt.text = LangConfig.getWord("30091",3) + "0" + String(num);
         this.getGiftNum = num;
         if(num <= 0)
         {
            this.rouletteBtn.enabled = false;
            this.rouletteBtn.mouseEnabled = false;
            if(Boolean(this.btnEff) && this.btn.contains(this.btnEff))
            {
               this.btn.removeChild(this.btnEff);
               EffectManager.removeEffect(this.btnEff);
               this.btnEff = null;
            }
         }
         else
         {
            this.rouletteBtn.enabled = true;
            this.rouletteBtn.mouseEnabled = true;
            if(!this.btnEff)
            {
               this.btnEff = EffectManager.addEffect("35146",this.btn,800,21,21,true,3);
            }
         }
      }
      
      public function set rouletteGetId(id:int) : void
      {
         this.getGiftId = id - 1;
         if(Boolean(this.backItem))
         {
            this.backItem.filters = null;
         }
         GameScene.instance.addFrameCallBack(this.frameHandle);
         this.runing = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

