package com.yiTian.view.modules.banhui.shenshou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.Vo_shenshou;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShenshouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   
   public class ViewShenShou extends Sprite
   {
      
      private var challengeBtn:Button;
      
      private var feedBtn:Button;
      
      private var enterBMapBtn:Button;
      
      private var desc:MyTextField;
      
      private var beastTypeLabel:MyTextField;
      
      private var beastTypeTxt:MyTextField;
      
      private var growTypeTxt:MyTextField;
      
      private var challTypeTxt:MyTextField;
      
      private var voBeast:Vo_shenshou;
      
      private var beastBit:Bitmap;
      
      private var totalGrowNum:int;
      
      private var conImg:Sprite;
      
      private var itemBit:Bitmap;
      
      private var _info:Object;
      
      private var imgList:Vector.<BitmapData>;
      
      private const INTERVALFRAM:int = 5;
      
      private var playIndex:int = 0;
      
      private var getDateTime:int;
      
      private var isFirst:Boolean = true;
      
      private var scale:Number;
      
      private var firstShowBeast:Boolean = false;
      
      private var oldState:int = -1;
      
      private var oldScale:Number = 0.3;
      
      private var begBeast:Bitmap;
      
      private var firstLoadBeast:Boolean = false;
      
      private var feedEff:Effect;
      
      private var change:Boolean = false;
      
      private var btnLastTime:int;
      
      private var curTime:int;
      
      private var recTime:String;
      
      private var lastTime:int;
      
      public function ViewShenShou()
      {
         super();
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":69,
            "width":670,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":284,
            "width":405,
            "height":162
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":439,
            "y":284,
            "width":260,
            "height":162
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":30,
            "y":285,
            "width":403,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":440,
            "y":285,
            "width":258,
            "height":24
         },Global.Img_Cdm);
         var mapBeast:Bitmap = new Bitmap();
         Utils.getLoadBitmap("resource/image/bang/BeastMap.jpg",mapBeast,{
            "x":29,
            "y":69
         });
         addChild(mapBeast);
         ComponentUtil.getTextField(LangConfig.getWord("30014",3),this,{
            "x":212,
            "y":287,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("30015",3),this,{
            "x":543,
            "y":287,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.challengeBtn = ComponentUtil.getButton(LangConfig.getWord("30016",3),"Button_Four",this,{
            "x":616,
            "y":314,
            "textColor":16184781
         },Global.Img_Cdm);
         this.feedBtn = ComponentUtil.getButton(LangConfig.getWord("30017",3),"Button_Four",this,{
            "x":616,
            "y":344,
            "textColor":16184781
         },Global.Img_Cdm);
         this.enterBMapBtn = ComponentUtil.getButton(LangConfig.getWord("30018",3),"Button_SendGift",this,{
            "x":478,
            "y":411,
            "textColor":16184781
         },Global.Img_Cdm);
         this.challengeBtn.callBack = this.challengeHandle;
         this.feedBtn.callBack = this.feedHandle;
         this.enterBMapBtn.callBack = this.enterMapHandle;
         this.desc = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":314,
            "size":12,
            "leading":4
         });
         this.desc.multiline = true;
         this.desc.mouseEnabled = true;
         this.desc.link("#fe0000");
         this.desc.htmlText = LangConfig.getWord("30019",3);
         this.desc.addEventListener(TextEvent.LINK,this.descLinkHandle);
         this.beastTypeTxt = ComponentUtil.getTextField("",this,{
            "x":449,
            "y":317,
            "size":12,
            "leading":0
         });
         this.beastTypeTxt.mouseEnabled = true;
         TipManager.bind(this.beastTypeTxt,LangConfig.getWord("30050",3));
         ComponentUtil.getTextField(LangConfig.getWord("30021",3),this,{
            "x":449,
            "y":347,
            "color":11380884,
            "size":12,
            "leading":0
         });
         this.growTypeTxt = ComponentUtil.getTextField("",this,{
            "x":502,
            "y":347,
            "size":12,
            "color":16043313,
            "leading":0
         });
         this.challTypeTxt = ComponentUtil.getTextField("",this,{
            "x":487,
            "y":382,
            "size":14,
            "leading":0
         });
         this.beastBit = new Bitmap();
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":447,
            "y":373,
            "width":250,
            "height":2
         },Global.Img_Cdm);
      }
      
      private function descLinkHandle(eve:TextEvent) : void
      {
         View_TianMing.instance.visible = true;
      }
      
      private function challengeHandle(evt:MouseEvent) : void
      {
         var pos:int = 0;
         if(this.voBeast.state == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30031",3));
            return;
         }
         if(Boolean(Model_bang.partyInfo))
         {
            pos = Model_bang.partyInfo.party_position;
            if(pos >= Model_bang.ZHANGLAO)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30030",3));
               return;
            }
         }
         if(this.voBeast.challBoo == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30054",3));
            return;
         }
         if(this.voBeast.challBoo == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30032",3));
            return;
         }
         ShenshouCGMessage.CG_TIAO_ZHAN();
      }
      
      private function feedHandle(evt:MouseEvent) : void
      {
         if(!GameUnitManager.hero.partyId)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30036",3));
            return;
         }
         if(this.voBeast.challBoo == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30038",3));
            return;
         }
         if(this.voBeast.feedState == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30103",3));
            return;
         }
         ShenshouCGMessage.CG_FEED_BEAST(1);
      }
      
      private function enterMapHandle(evt:MouseEvent) : void
      {
         ShenshouCGMessage.CG_ENTER_BEAST();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirst)
            {
               this.init();
               this.isFirst = false;
            }
            ShenshouCGMessage.CG_SHEN_SHOU();
            if(this.firstLoadBeast)
            {
               GameScene.instance.addFrameCallBack(this.play);
            }
         }
         else
         {
            if(GameScene.instance.hasFrameCallBack(this.runTime))
            {
               GameScene.instance.removeFrameCallBack(this.runTime);
               this.enterBMapBtn.transform.colorTransform = Util.colorNomal;
            }
            this.removeFeedEff();
         }
      }
      
      private function loadBeast() : void
      {
         MassLoader.add("modelRes/role/body/stand/56981.swf",this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function onComplete(info:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         if(!this.conImg)
         {
            this.conImg = new Sprite();
            addChild(this.conImg);
            this.itemBit = new Bitmap();
            this.conImg.addChild(this.itemBit);
            this.conImg.x = 370;
            this.conImg.y = 220;
         }
         this._info = info;
         this._info.content.init();
         this.imgList = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < this.INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % this.INTERVALFRAM == 0)
            {
               c = info.applicationDomain.getDefinition("_" + (1 * this._info.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.play);
      }
      
      private function play(interval:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.play);
         }
         if(this.playIndex < this.imgList.length)
         {
            if(this.imgList[this.playIndex] != null)
            {
               this.itemBit.x = this._info.content.rect[this._info.content.actionFrame + this.playIndex / this.INTERVALFRAM][0];
               this.itemBit.y = this._info.content.rect[this._info.content.actionFrame + this.playIndex / this.INTERVALFRAM][1];
               this.itemBit.bitmapData = this.imgList[this.playIndex];
               this.reSetState();
            }
            ++this.playIndex;
         }
         else
         {
            this.playIndex = 0;
         }
      }
      
      private function reSetState() : void
      {
         if(!this.firstShowBeast)
         {
            if(this.firstLoadBeast)
            {
               if(Boolean(this.conImg) && this.hasOwnProperty("conImg"))
               {
                  this.removeChild(this.conImg);
                  this.conImg = null;
               }
               this.conImg = new Sprite();
               this.addChild(this.conImg);
               this.conImg.addChild(this.itemBit);
               this.conImg.x = 370;
               this.conImg.y = 220;
            }
            this.firstShowBeast = true;
            this.conImg.scaleX *= this.scale;
            this.conImg.scaleY *= this.scale;
            this.conImg.scaleZ *= this.scale;
         }
         this.firstLoadBeast = true;
      }
      
      public function removeFeedEff() : void
      {
         if(Boolean(this.feedEff))
         {
            EffectManager.removeEffect(this.feedEff);
         }
      }
      
      public function set voData(vo:Vo_shenshou) : void
      {
         var dir:String = null;
         var px:Number = NaN;
         var py:Number = NaN;
         var _x:Number = NaN;
         var _y:Number = NaN;
         if(!visible)
         {
            return;
         }
         this.voBeast = vo;
         if(this.oldState != vo.state)
         {
            this.oldState = vo.state;
            this.setState(vo.state);
         }
         if(this.voBeast.feedState == 1)
         {
            dir = "35075";
            px = 37;
            py = 11;
            _x = this.feedBtn.x;
            _y = this.feedBtn.y;
            this.feedEff = EffectManager.addEffect(dir,this,1000,_x + px,_y + py,true);
            addChild(this.feedEff);
         }
         else if(this.voBeast.feedState == 2)
         {
            this.removeFeedEff();
         }
         if(UIManager.feedBeast.visible)
         {
            this.removeFeedEff();
         }
         if(vo.state == 3)
         {
            this.growTypeTxt.text = LangConfig.getWord("30048",3);
         }
         else
         {
            this.growTypeTxt.htmlText = String(vo.grawNum) + "/" + this.totalGrowNum;
         }
         this.getDateTime = getTimer();
         if(vo.challBoo != 3 && GameScene.instance.hasFrameCallBack(this.runTime))
         {
            vo.challTime = 0;
            GameScene.instance.removeFrameCallBack(this.runTime);
            this.enterBMapBtn.transform.colorTransform = Util.colorNomal;
         }
         this.setChall(vo.challBoo,vo.challTime);
      }
      
      private function setState(s:int) : void
      {
         var str:String = "";
         switch(s)
         {
            case 0:
               str = LangConfig.getWord("30022",3);
               this.totalGrowNum = 200;
               this.begBeast = new Bitmap();
               Utils.getLoadBitmap("resource/image/bang/beastBeg.png",this.begBeast,{
                  "x":30,
                  "y":75
               });
               addChild(this.begBeast);
               if(Boolean(this.conImg) && this.contains(this.conImg))
               {
                  this.removeChild(this.conImg);
                  this.conImg = null;
                  GameScene.instance.removeFrameCallBack(this.play);
               }
               break;
            case 1:
               str = LangConfig.getWord("30023",3);
               this.totalGrowNum = 500;
               this.scale = 0.3;
               if(Boolean(this.begBeast) && this.contains(this.begBeast))
               {
                  removeChild(this.begBeast);
               }
               if(this.firstLoadBeast)
               {
                  GameScene.instance.addFrameCallBack(this.play);
               }
               break;
            case 2:
               str = LangConfig.getWord("30024",3);
               this.totalGrowNum = 1000;
               this.scale = 0.4;
               break;
            case 3:
               str = LangConfig.getWord("30025",3);
               this.scale = 0.5;
         }
         if(s != 0)
         {
            this.firstShowBeast = false;
            if(!this.firstLoadBeast)
            {
               this.loadBeast();
            }
         }
         this.beastTypeTxt.htmlText = "<font color=\'#ADA894\'>" + LangConfig.getWord("30020",3) + "   " + "</font>" + str;
      }
      
      private function btnToWhite() : void
      {
         if(getTimer() - this.btnLastTime > 500)
         {
            this.btnLastTime = getTimer();
            this.change = !this.change;
            if(this.change)
            {
               this.enterBMapBtn.transform.colorTransform = Util.colorWhite2;
            }
            else
            {
               this.enterBMapBtn.transform.colorTransform = Util.colorNomal;
            }
         }
      }
      
      private function setChall(s:int, t:int) : void
      {
         var str:String = "";
         switch(s)
         {
            case 1:
               str = LangConfig.getWord("30026",3);
               this.challTypeTxt.x = 505;
               this.challengeBtn.enabled = false;
               break;
            case 2:
               str = LangConfig.getWord("30027",3);
               this.challTypeTxt.x = 500;
               this.challengeBtn.enabled = true;
               break;
            case 3:
               str = LangConfig.getWord("30028",3);
               this.challTypeTxt.x = 478;
               this.challengeBtn.enabled = false;
               if(t >= 0)
               {
                  this.curTime = t;
                  this.recTime = DateUtil.getMSBySecond2(this.curTime);
                  str += "<font color=\'#f4cd31\'>" + this.recTime + "</font>";
               }
               if(t > 0)
               {
                  GameScene.instance.addFrameCallBack(this.runTime);
               }
         }
         this.challTypeTxt.htmlText = str;
      }
      
      private function runTime() : void
      {
         if(this.curTime * 1000 - (getTimer() - this.getDateTime) <= 0 || !visible || !UIManager.banghuiBack.visible)
         {
            GameScene.instance.removeFrameCallBack(this.runTime);
            this.enterBMapBtn.transform.colorTransform = Util.colorNomal;
         }
         this.btnToWhite();
         if(getTimer() - this.lastTime >= 1000)
         {
            this.lastTime = getTimer();
            this.recTime = DateUtil.getMSBySecond2(this.curTime - (getTimer() - this.getDateTime) / 1000);
            this.challTypeTxt.htmlText = LangConfig.getWord("30028",3) + "<font color=\'#f4cd31\'>" + this.recTime + "</font>";
         }
      }
   }
}

