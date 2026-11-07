package com.yiTian.view.modules.roleHead
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MusicManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.BufferCGMessage;
   import com.yiTian.net.message.cg.HumanCGMessage;
   import com.yiTian.net.message.cg.TiLiCGMessage;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.net.message.gc.TiLiGCMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.cast.View_equip_intensify;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFormatAlign;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_HeroHead extends MainUIBase
   {
      
      public static const VIP_DISABLED:String = "VIPDisabled";
      
      public static const VIP1:String = "VIPLv1";
      
      public static const VIP2:String = "VIPLv2";
      
      public static const VIP3:String = "VIPLv3";
      
      public static var isInit:Boolean = false;
      
      private static var statX:int = 115;
      
      private static var statW:int = 104;
      
      private static const WEITIAO:int = 10;
      
      public static var isFirst:Boolean = true;
      
      public static var isUsingNew:Boolean = true;
      
      public static var playerName:String = "";
      
      private var ChongZhi_Button:Button;
      
      private var ShouCang_button:Button;
      
      private var Button_HPUp:Button;
      
      private var Button_MPUp:Button;
      
      private var Button_TiLiUp:Button;
      
      private var PlayerLever_text:MyTextField;
      
      private var PlayerName_text:MyTextField;
      
      private var headBM:Bitmap;
      
      private var PlayerLeaderHead:Bitmap;
      
      private var PlayerLeaveHead:Bitmap;
      
      private var hpBM:Bitmap;
      
      private var hpMask:Shape;
      
      private var hpTip:Sprite;
      
      private var mpBM:Bitmap;
      
      private var mpMask:Shape;
      
      private var mpTip:Sprite;
      
      private var tlBM:Bitmap;
      
      private var tlMask:Shape;
      
      private var tlpTip:Sprite;
      
      private var vipBM:Bitmap;
      
      private var vip1:Bitmap;
      
      private var vip2:Bitmap;
      
      private var vip3:Bitmap;
      
      private var buffterVec:Vector.<BuffterView>;
      
      private const WIDTH:int = 120;
      
      private const HEIGHT:int = 10;
      
      private var vipItem:VIP_item;
      
      private var xinYueContain:Sprite;
      
      private var btnClose:Button;
      
      private var btnOpen:Button;
      
      private var LZbmp:LZBmp = new LZBmp();
      
      private var bmpXinYue:Bitmap = new Bitmap();
      
      private var _timeOut:int;
      
      private var tiliYb:int;
      
      private var tiliZhi:int;
      
      private var tiliTimes:int;
      
      private var desCr:String;
      
      private var tf:MyTextField;
      
      private const bufferXY:Point = new Point(102,74);
      
      private var addBuffVec:Vector.<DisplayObject>;
      
      public function View_HeroHead()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_Player",this,{
            "x":14,
            "y":0
         },Global.Scenedm);
         isInit = true;
         this.ChongZhi_Button = ComponentUtil.getButton("","Button_Chong",this,{
            "x":0,
            "y":18,
            "textColor":16184781
         },Global.Img_Cdm);
         this.ChongZhi_Button.name = "ChongZhi_Button";
         this.ChongZhi_Button.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         Enum_explor.bindDic[Enum_explor.BTN_CHONGZHI] = this.ChongZhi_Button;
         this.ShouCang_button = ComponentUtil.getButton(LangConfig.getWord(Global.pf == "" ? "1114" : "1113",0),"Button_Chang",this,{
            "x":27,
            "y":74,
            "textColor":16184781
         },Global.Img_Cdm);
         this.ShouCang_button.LabelResize(4,2);
         this.ShouCang_button.name = "ShouCang_button";
         this.ShouCang_button.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         TipManager.bind(this.ShouCang_button,LangConfig.getWord(Global.pf == "" ? "1003" : "1112",0));
         TipManager.bind(this.ChongZhi_Button,LangConfig.getWord("1002",0));
         this.vipItem = new VIP_item();
         addChild(this.vipItem);
         this.vipItem.x = 52;
         this.vipItem.y = 81;
         TipManager.bind(this.vipItem,LangConfig.getWord("10363",1));
         Enum_explor.bindDic[Enum_explor.BTN_VIP] = this.vipItem;
         this.Button_HPUp = ComponentUtil.getButton("","Button_Jia",this,{
            "x":223,
            "y":31
         },Global.Img_Cdm);
         this.Button_HPUp.name = "Button_HPUp";
         this.Button_HPUp.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.Button_MPUp = ComponentUtil.getButton("","Button_Jia",this,{
            "x":223,
            "y":44
         },Global.Img_Cdm);
         this.Button_MPUp.name = "Button_MPUp";
         this.Button_MPUp.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.Button_TiLiUp = ComponentUtil.getButton("","Button_Jia",this,{
            "x":223,
            "y":57
         },Global.Img_Cdm);
         this.Button_TiLiUp.name = "Button_TiLiUp";
         this.Button_TiLiUp.addEventListener(MouseEvent.CLICK,this.btnClickHandler);
         this.Button_TiLiUp.addEventListener(MouseEvent.MOUSE_OVER,this.tilOverHd);
         this.PlayerLever_text = ComponentUtil.getTextField("106",this,{
            "x":89,
            "y":7,
            "color":16774337,
            "size":11,
            "leading":0
         });
         this.PlayerLever_text.realWidth = 20;
         this.PlayerLever_text.align = TextFormatAlign.CENTER;
         this.PlayerName_text = ComponentUtil.getTextField("",this,{
            "x":158.5,
            "y":10,
            "color":9760866
         });
         this.headBM = new Bitmap();
         this.headBM.x = 23;
         this.headBM.y = -4;
         addChild(this.LZbmp);
         this.headBM.cacheAsBitmap = true;
         addChild(this.headBM);
         var setMask:DisplayObject = ComponentUtil.getDisplayObject("Player_Head_Mask",this,{
            "x":30,
            "y":11,
            "name":"setMask"
         },ComponentUtil.domain);
         setMask.alpha = 0;
         (setMask as Sprite).buttonMode = true;
         setMask.addEventListener(MouseEvent.CLICK,this.headClickHandler);
         this.hpBM = ComponentUtil.getBitmap("Player_Head_HP",this,{
            "x":102,
            "y":32
         },Global.Scenedm);
         this.hpMask = new Shape();
         this.draw(this.hpMask,this.WIDTH);
         addChild(this.hpMask);
         this.hpMask.x = this.hpBM.x;
         this.hpMask.y = this.hpBM.y;
         this.hpBM.mask = this.hpMask;
         this.hpTip = this.getSprite(this.WIDTH,this.HEIGHT);
         this.hpTip.x = this.hpBM.x;
         this.hpTip.y = this.hpBM.y;
         addChild(this.hpTip);
         this.mpBM = ComponentUtil.getBitmap("Player_Head_MP",this,{
            "x":102,
            "y":45
         },Global.Scenedm);
         this.mpMask = new Shape();
         this.draw(this.mpMask,this.WIDTH);
         addChild(this.mpMask);
         this.mpMask.x = this.mpBM.x;
         this.mpMask.y = this.mpBM.y;
         this.mpBM.mask = this.mpMask;
         this.mpTip = this.getSprite(this.WIDTH,this.HEIGHT);
         this.mpTip.x = this.mpBM.x;
         this.mpTip.y = this.mpBM.y;
         addChild(this.mpTip);
         this.tlBM = ComponentUtil.getBitmap("Player_Head_TL",this,{
            "x":102,
            "y":58
         },Global.Scenedm);
         this.tlMask = new Shape();
         this.draw(this.tlMask,this.WIDTH);
         addChild(this.tlMask);
         this.tlMask.x = this.tlBM.x;
         this.tlMask.y = this.tlBM.y;
         this.tlBM.mask = this.tlMask;
         this.tlpTip = this.getSprite(this.WIDTH,this.HEIGHT);
         this.tlpTip.x = this.tlBM.x;
         this.tlpTip.y = this.tlBM.y;
         addChild(this.tlpTip);
         this.buffterVec = new Vector.<BuffterView>();
         this.btnClose = ComponentUtil.getButton("","Button_Sound",this,{
            "x":16,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnClose.name = "Button_Sound";
         this.btnOpen = ComponentUtil.getButton("","Sound_Closed",this,{
            "x":16,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnOpen.name = "Sound_Closed";
         this.btnClose.callBack = this.btnOpen.callBack = this.soundClick;
         TipManager.bind(this.btnClose,LangConfig.getWord("10359",1));
         TipManager.bind(this.btnOpen,LangConfig.getWord("10360",1));
      }
      
      public function changeBtnEnable(value:Boolean) : void
      {
         this.vipItem.mouseEnabled = this.Button_HPUp.mouseEnabled = this.Button_MPUp.mouseEnabled = this.Button_TiLiUp.mouseEnabled = this.ChongZhi_Button.mouseEnabled = this.ShouCang_button.mouseEnabled = value;
         var filter:Array = value ? [] : Util.disabled;
         this.vipItem.filters = this.Button_HPUp.filters = this.Button_MPUp.filters = this.Button_TiLiUp.filters = this.ChongZhi_Button.filters = this.ShouCang_button.filters = filter;
      }
      
      public function enabledCZBtn(boo:Boolean) : void
      {
         this.ChongZhi_Button.enabled = boo;
         this.ChongZhi_Button.mouseEnabled = boo;
      }
      
      public function addDia(diaLvl:int, isYearDia:int, huangZLv:int = 0, isHuangZYear:int = 0, isHuiyuan:int = 0, isHuiyuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperH:int = 0) : void
      {
         this.LZbmp.bitmapData = null;
         if(Global.pf == "qqgame")
         {
            if(superLanYear == 0 && superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLan(superLan),this.LZbmp.bmp,null,function():void
               {
                  align(3);
               });
               return;
            }
            if(superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLanYear(superLan),this.LZbmp.bmp,null,function():void
               {
                  align(3);
               });
               return;
            }
            if(isYearDia == 0 && diaLvl > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl(diaLvl),this.LZbmp.bmp,null,function():void
               {
                  align(3);
               });
            }
            else if(diaLvl > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl(diaLvl),this.LZbmp.bmp,null,function():void
               {
                  align(3);
               });
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(isHuiyuanYear == 0 && isHuiyuan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getQQHuiYuan(isHuiyuan),this.LZbmp.bmp,null,function():void
               {
                  align(0);
               });
            }
            else if(isHuiyuan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getQQHuiYuanYear(isHuiyuan),this.LZbmp.bmp,null,function():void
               {
                  align(0);
               });
            }
            if(Global.pf == Enum_SPStr.GUANWANG)
            {
               this.align(0);
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(!isSuperH)
            {
               if(isHuangZYear == 0 && huangZLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl_h(huangZLv),this.LZbmp.bmp,null,function():void
                  {
                     align(3);
                  });
               }
               else if(huangZLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl_h(huangZLv),this.LZbmp.bmp,null,function():void
                  {
                     align(3);
                  });
               }
            }
            else if(isHuangZYear == 0 && huangZLv > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl_superH(huangZLv),this.LZbmp.bmp,null,function():void
               {
                  align(3);
               });
            }
            else if(huangZLv > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl_superH(huangZLv),this.LZbmp.bmp,null,function():void
               {
                  align(3);
               });
            }
         }
      }
      
      private function align(spac:int = 0) : void
      {
         var nu1:int = (this.LZbmp.width + this.PlayerName_text.width) / 2;
         this.LZbmp.x = statX + statW / 2 - nu1 + WEITIAO;
         this.PlayerName_text.x = this.LZbmp.x + this.LZbmp.width;
         this.LZbmp.y = this.PlayerName_text.y + spac;
         if(Global.pf == Enum_SPStr.GUANWANG)
         {
            if(Boolean(this.bmpXinYue))
            {
               this.bmpXinYue.bitmapData = null;
               if(Boolean(this.xinYueContain) && this.xinYueContain.contains(this.bmpXinYue))
               {
                  this.xinYueContain.removeChild(this.bmpXinYue);
               }
            }
            if(Boolean(GameUnitManager.hero.xinYueLvl))
            {
               this.bmpXinYue = Utils.getLoadBitmap("resource/image/Diamond/xinYueIcon.png",this.bmpXinYue,null,this.comAlign);
            }
         }
      }
      
      private function comAlign() : void
      {
         if(!this.xinYueContain)
         {
            this.xinYueContain = new Sprite();
            this.xinYueContain.mouseEnabled = true;
            this.xinYueContain.buttonMode = true;
            addChild(this.xinYueContain);
            this.xinYueContain.addEventListener(MouseEvent.CLICK,this.cliHd);
         }
         this.xinYueContain.addChild(this.bmpXinYue);
         TipManager.bind(this.xinYueContain,"点击设置是否显示心悦徽章");
         var nu2:int = (this.LZbmp.width + this.PlayerName_text.width + this.bmpXinYue.width) / 2;
         this.LZbmp.x = statX + statW / 2 - nu2 + WEITIAO;
         this.PlayerName_text.x = this.LZbmp.x + this.LZbmp.width;
         this.xinYueContain.x = this.PlayerName_text.x + this.PlayerName_text.textWidth / 2 + this.PlayerName_text.width / 2 + 3;
         this.xinYueContain.y = this.PlayerName_text.y + 1;
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         YelloDiaCGMessage.CG_SET_XINYUE();
      }
      
      public function getVipEff() : void
      {
         EffecObj.getEffec(this.vipItem);
         this._timeOut = setTimeout(this.removeVipEff,15000);
      }
      
      public function removeVipEff() : void
      {
         EffecObj.removeEffect(this.vipItem);
         if(Boolean(this._timeOut))
         {
            clearTimeout(this._timeOut);
         }
      }
      
      public function setChongZhiEff(value:Boolean) : void
      {
         if(value)
         {
            EffecObj.getEffec(this.ChongZhi_Button);
         }
         else
         {
            EffecObj.removeEffect(this.ChongZhi_Button);
         }
      }
      
      public function updateTiliTip(ss:String, yb:int, tl:int, times:int) : void
      {
         this.tiliYb = yb;
         this.tiliZhi = tl;
         this.tiliTimes = times;
         this.desCr = ss;
      }
      
      private function tilOverHd(e:MouseEvent) : void
      {
         if(!isUsingNew)
         {
            return;
         }
         if(GameUnitManager.hero.vigor == GameUnitManager.hero.maxvigor)
         {
            TipManager.bind(this.Button_TiLiUp,"当前体力已满无法继续购买");
         }
         else
         {
            TipManager.bind(this.Button_TiLiUp,this.desCr);
         }
      }
      
      private function soundClick(e:MouseEvent) : void
      {
         if(e.target.name == "Button_Sound")
         {
            HumanCGMessage.CG_SOUND(1);
         }
         else if(e.target.name == "Sound_Closed")
         {
            HumanCGMessage.CG_SOUND(0);
         }
      }
      
      public function setSound(type:int) : void
      {
         if(Boolean(type))
         {
            MusicManager.getInstance().allVolume = 0;
            this.btnClose.visible = false;
            this.btnOpen.visible = true;
         }
         else
         {
            MusicManager.getInstance().allVolume = 0.5;
            this.btnClose.visible = true;
            this.btnOpen.visible = false;
         }
      }
      
      public function getTiliBtnPos() : Point
      {
         return localToGlobal(new Point(this.Button_MPUp.x,this.Button_MPUp.y));
      }
      
      public function getExpBarXY(_type:int) : Point
      {
         if(_type == 1)
         {
            return localToGlobal(new Point(this.hpBM.x + this.hpBM.width,this.hpBM.y));
         }
         return localToGlobal(new Point(this.mpBM.x + this.mpBM.width,this.mpBM.y));
      }
      
      public function loadHeroHead() : void
      {
         Utils.getLoadBitmap("resource/image/icon/23" + Enum_job.getBaseJob(GameUnitManager.hero.job) + "0" + GameUnitManager.hero.sex + ".png",this.headBM,null,null,MassLoader.LEVEL0);
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      protected function headClickHandler(event:Event) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE || Global.sceneMap == 14401)
         {
            return;
         }
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.visible = !pan.visible;
            if(pan.visible)
            {
               pan.showView(0);
            }
         });
      }
      
      public function getTili() : void
      {
         this.Button_TiLiUp.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function getBtnPoint(_target:Object) : Point
      {
         return localToGlobal(new Point(_target.x,_target.y));
      }
      
      protected function btnClickHandler(event:MouseEvent) : void
      {
         var btn:Button;
         var hero:Hero;
         var vec:Vector.<Vo_valuable> = null;
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         btn = event.target as Button;
         hero = GameUnitManager.hero;
         switch(btn.name)
         {
            case "Button_HPUp":
               if(hero.hp < hero.hpMax)
               {
                  BufferCGMessage.CG_ADD_HP_MP(1);
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10361",1) + "</font>");
               break;
            case "Button_MPUp":
               if(hero.mp < hero.mpMax)
               {
                  BufferCGMessage.CG_ADD_HP_MP(2);
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10362",1) + "</font>");
               break;
            case "Button_TiLiUp":
               if(isUsingNew)
               {
                  if(GameUnitManager.hero.vigor == GameUnitManager.hero.maxvigor)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("1166",0));
                     return;
                  }
                  if(GameUnitManager.hero.vigor + this.tiliZhi > GameUnitManager.hero.maxvigor)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("1167",0));
                     return;
                  }
                  if(this.tiliTimes == -1)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("1168",0));
                     return;
                  }
                  if(GameUnitManager.hero.money < this.tiliYb)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("1169",0));
                     return;
                  }
                  UIManager.tiliProm.show(function():void
                  {
                     TiLiGCMessage.curTili = GameUnitManager.hero.vigor;
                     TiLiCGMessage.CG_BUYTILI();
                  },LangConfig.getWord("1170",0,this.tiliYb,this.tiliZhi));
                  break;
               }
               UIManager.tiliStore.visible = !UIManager.tiliStore.visible;
               break;
            case "ShouCang_button":
               if(Global.pf == "")
               {
                  ExternalInterface.call("bookmark");
                  break;
               }
               navigateToURL(new URLRequest(Global.config.lunWebsite),"_blank");
               break;
            case "ChongZhi_Button":
               UIManager.heroHead.setChongZhiEff(false);
               UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
               return;
         }
      }
      
      public function update_vip(_index:int) : void
      {
         this.vipItem.update(_index);
         TipManager.bind(this.vipItem,Boolean(_index) ? LangConfig.getWord("10363",1) : LangConfig.getWord("10363",1));
         if(_index == 1)
         {
            this.setVIPImg(View_HeroHead.VIP1);
         }
         else if(_index == 2)
         {
            this.setVIPImg(View_HeroHead.VIP2);
         }
         else if(_index == 3)
         {
            this.setVIPImg(View_HeroHead.VIP3);
         }
      }
      
      public function update() : void
      {
         var hero:Hero = null;
         var w:int = 0;
         hero = GameUnitManager.hero;
         this.PlayerLever_text.text = hero.level.toString();
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            this.PlayerName_text.htmlText = Model_heFu.repNameByHero(hero.name);
         }
         else
         {
            this.PlayerName_text.htmlText = "";
            if(playerName != "")
            {
               this.PlayerName_text.text = Model_heFu.repNameByHero(playerName);
               playerName = "";
            }
            else
            {
               this.PlayerName_text.text = Model_heFu.repNameByHero(hero.name);
            }
         }
         playerName = this.PlayerName_text.text;
         var numRe:int = this.PlayerName_text.textWidth / 2;
         this.PlayerName_text.x = statX + statW / 2 - numRe + WEITIAO;
         w = hero.hp > hero.hpMax ? this.WIDTH : int(hero.hp / hero.hpMax * this.WIDTH);
         this.hpMask.width = w;
         w = hero.mp > hero.mpMax ? this.WIDTH : int(hero.mp / hero.mpMax * this.WIDTH);
         this.mpMask.width = w;
         w = hero.vigor > hero.maxvigor ? this.WIDTH : int(hero.vigor / hero.maxvigor * this.WIDTH);
         this.tlMask.width = w;
         TipManager.bind(this.hpTip,LangConfig.getWord("10082",1) + hero.hp + "/" + hero.hpMax);
         TipManager.bind(this.mpTip,LangConfig.getWord("10364",1) + hero.mp + "/" + hero.mpMax);
         TipManager.bind(this.tlpTip,LangConfig.getWord("10365",1,hero.vigor,hero.maxvigor));
         this.vipItem.update(hero.vip);
         TipManager.bind(this.vipItem,Boolean(hero.vip) ? LangConfig.getWord("10363",1) : LangConfig.getWord("10363",1));
         if(hero.vip == 1)
         {
            this.setVIPImg(View_HeroHead.VIP1);
         }
         else if(hero.vip == 2)
         {
            this.setVIPImg(View_HeroHead.VIP2);
         }
         else if(hero.vip == 3)
         {
            this.setVIPImg(View_HeroHead.VIP3);
         }
         if(hero.vip != 0)
         {
            View_equip_intensify.updateText(hero.vip);
         }
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Enum_SPStr.isIwan(Global.pf) || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            this.addDia(GameUnitManager.hero.ylDiaLvl,GameUnitManager.hero.isYearDia,GameUnitManager.hero.huangZuanLvl,GameUnitManager.hero.isHuangZuanYear,GameUnitManager.hero.isHuiyuan,GameUnitManager.hero.isHuiyuanYear,GameUnitManager.hero.superLan,GameUnitManager.hero.superLanYear,GameUnitManager.hero.isSuperHuang);
         }
         else if(Global.pf == Enum_SPStr.QQ3366)
         {
            this.addSpeDia(GameUnitManager.hero.sanLiu);
         }
      }
      
      private function addSpeDia(sanLiuLvl:int) : void
      {
         this.LZbmp.bitmapData = null;
         var str:String = "resource/image/shouchong/HY_" + sanLiuLvl + ".png";
         Utils.getLoadBitmap(str,this.LZbmp.bmp,null,this.align);
      }
      
      public function showBuffter() : void
      {
         var buffVOVec:Vector.<Vo_Buffer> = BuffterVO.roleBuffVOVec;
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
               }
            });
            this.resetP();
         }
      }
      
      private function resetP() : void
      {
         var starX:Number = NaN;
         starX = 0;
         if(Boolean(this.addBuffVec) && this.addBuffVec.length > 0)
         {
            this.addBuffVec.forEach(function(item:DisplayObject, index:int, vec:Vector.<DisplayObject>):void
            {
               item.x = bufferXY.x + (BuffterView.WIDTH + 10) * index;
               item.y = bufferXY.y;
            });
            starX = this.addBuffVec[this.addBuffVec.length - 1].x + BuffterView.WIDTH + 10;
         }
         if(Boolean(this.buffterVec))
         {
            this.buffterVec.forEach(function(item:BuffterView, index:int, vec:Vector.<BuffterView>):void
            {
               if(item.visible)
               {
                  item.x = (Boolean(starX) ? starX : bufferXY.x) + (BuffterView.WIDTH + 10) * index;
                  item.y = bufferXY.y;
               }
            });
         }
      }
      
      public function addBuff(d:DisplayObject) : void
      {
         if(!this.addBuffVec)
         {
            this.addBuffVec = new Vector.<DisplayObject>();
         }
         if(this.addBuffVec.indexOf(d) < 0)
         {
            addChild(d);
            this.addBuffVec.push(d);
            this.resetP();
         }
      }
      
      public function removeBuff(d:DisplayObject) : void
      {
         if(this.addBuffVec.indexOf(d) >= 0)
         {
            removeChild(d);
            this.addBuffVec.splice(this.addBuffVec.indexOf(d),1);
            this.resetP();
         }
      }
      
      public function buffItemUse(item:Vo_item, count:int) : void
      {
         var buffVO:Vo_Buffer = null;
         var oldBuff:Vo_Buffer = null;
         var oldItem:Vo_item = null;
         var buffVOVec:Vector.<Vo_Buffer> = BuffterVO.roleBuffVOVec;
         buffVO = new Vo_Buffer(item.result);
         if(buffVOVec.some(function(element:Vo_Buffer, index:int, v:Vector.<Vo_Buffer>):Boolean
         {
            if(element.categories == buffVO.categories && element.propsId != item.id)
            {
               oldBuff = element;
               return true;
            }
            return false;
         }))
         {
            oldItem = new Vo_item();
            oldItem.id = oldBuff.propsId;
            oldItem.Init_lib();
            View_Alert.show(LangConfig.getWord("10366",1,this.getColor(item),this.getColor(oldItem)),View_Alert.OK_CANCAL,this.okCallBack,null,{
               "i":item,
               "c":count
            });
         }
         else
         {
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,item.gridId,count);
         }
      }
      
      public function getBuffUse(idArr:Array) : Boolean
      {
         var _id:int = 0;
         var voBuff:Vo_Buffer = null;
         var buffVOVec:Vector.<Vo_Buffer> = BuffterVO.roleBuffVOVec;
         var i:int = 0;
         loop0:
         while(i < idArr.length)
         {
            _id = int(idArr[i]);
            var _loc6_:int = 0;
            var _loc7_:* = buffVOVec;
            do
            {
               for each(voBuff in _loc7_)
               {
               }
               i++;
               continue loop0;
            }
            while(voBuff.propsId != _id);
            return true;
         }
         return false;
      }
      
      private function okCallBack(o:Object) : void
      {
         BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,o.i.gridId,o.c);
      }
      
      private function getColor(item:Vo_item) : String
      {
         var str:String = item.str_name;
         if(item.lv == Enum_color.WHITE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.WHITE));
         }
         else if(item.lv == Enum_color.GREEN)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.GREEN));
         }
         else if(item.lv == Enum_color.BLUE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.BLUE));
         }
         else if(item.lv == Enum_color.PURPLE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.PURPLE));
         }
         return str;
      }
      
      public function setVIPImg(type:String) : void
      {
      }
      
      private function getSprite(w:Number, h:Number) : Sprite
      {
         var temp:Sprite = new Sprite();
         var g:Graphics = temp.graphics;
         g.beginFill(16777215,0);
         g.drawRect(0,0,w,h);
         g.endFill();
         return temp;
      }
      
      override public function resetPosition() : void
      {
         x = 5;
         y = 5;
      }
   }
}

