package com.yiTian.view.modules.vip
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_Vip;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.VIPCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.chargeGuide.SpeEff;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class VipPanel extends Panel
   {
      
      public static var firstApp:Boolean = true;
      
      public static var canAddK:Boolean = false;
      
      public static var kuangVec:Vector.<SpeEff> = new Vector.<SpeEff>();
      
      private var back:DisplayObject;
      
      private var bmBack:Bitmap;
      
      private var bmHead:Bitmap;
      
      private var txtName:MyTextField;
      
      private var bmVipIcon:Bitmap;
      
      private var txtTime:MyTextField;
      
      private var btnRenewals:Button;
      
      private var vecTBB:Vector.<TabButton>;
      
      private var bmVip:Bitmap;
      
      private var txtVipInfo:MyTextField;
      
      private var txtGoBack:MyTextField;
      
      private var vecTxtEvent:Vector.<MyTextField>;
      
      private var titleBg:Bitmap;
      
      private var vecId:Vector.<int> = new <int>[46342,46341,46340];
      
      private var curTBB:TabButton;
      
      public var days:int;
      
      private var isFirstOpen:Boolean = true;
      
      public function VipPanel()
      {
         super();
      }
      
      public static function firstApply() : void
      {
         VIPCGMessage.CG_VIP_OPEN();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var b:TabButton = null;
         var t:MyTextField = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":400,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":30,
            "y":48,
            "width":340,
            "height":76
         },Global.Img_Cdm);
         this.back = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":30,
            "y":150,
            "width":340,
            "height":342
         },Global.Img_Cdm);
         move = new Rectangle(0,0,400,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":366,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":41,
            "y":58,
            "width":56,
            "height":56
         },Global.Img_Cdm);
         this.bmBack = new Bitmap();
         this.bmBack.x = 41;
         this.bmBack.y = 58;
         addChild(this.bmBack);
         this.bmHead = new Bitmap();
         this.bmHead.x = this.bmBack.x + 3;
         this.bmHead.y = this.bmBack.y + 3;
         addChild(this.bmHead);
         this.txtName = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":70,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.bmVipIcon = new Bitmap();
         this.bmVipIcon.x = 150;
         this.bmVipIcon.y = 70;
         addChild(this.bmVipIcon);
         this.txtTime = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":96,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.btnRenewals = ComponentUtil.getButton(LangConfig.getWord("10392",1),"Button_Orange",this,{
            "x":282,
            "y":92,
            "textColor":16773818
         },Global.Img_Cdm);
         this.btnRenewals.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         this.bmVip = new Bitmap();
         this.bmVip.x = 44;
         this.bmVip.y = 158;
         addChild(this.bmVip);
         this.txtVipInfo = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":210,
            "color":11904647,
            "size":12,
            "leading":5
         });
         this.txtVipInfo.realWidth = 272;
         this.txtVipInfo.leading = 4;
         this.txtVipInfo.multiline = true;
         i = 3;
         var v:Vector.<String> = new <String>[LangConfig.getWord("10393",1),LangConfig.getWord("10394",1),LangConfig.getWord("10395",1)];
         this.vecTBB = new Vector.<TabButton>(i,true);
         while(Boolean(i--))
         {
            b = ComponentUtil.getTabButton(v[i],"TabButton_Four",this,{"visible":false},Global.Img_Cdm);
            b.textColor = 10611072;
            b.chooseColor = 16449280;
            b.x = 35 + 81 * i;
            b.y = 129;
            b.index = i;
            b.addEventListener(MouseEvent.CLICK,this.tbbOnClick);
            this.vecTBB[i] = b;
         }
         this.vecTBB[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         this.txtGoBack = ComponentUtil.getTextField("",this,{
            "color":52224,
            "x":250
         });
         this.txtGoBack.type = TextFieldType.INPUT;
         this.txtGoBack.selectable = false;
         this.txtGoBack.restrict = "";
         this.txtGoBack.addEventListener(TextEvent.LINK,this.linkEvent);
         i = 8;
         this.vecTxtEvent = new Vector.<MyTextField>(i,true);
         while(Boolean(i--))
         {
            t = ComponentUtil.getTextField("",this,{
               "color":52224,
               "x":325
            });
            t.type = TextFieldType.INPUT;
            t.selectable = false;
            t.restrict = "";
            t.tabIndex = i;
            t.addEventListener(TextEvent.LINK,this.linkEvent);
            this.vecTxtEvent[i] = t;
         }
         firstApply();
      }
      
      protected function btnOnClick(e:MouseEvent) : void
      {
         switch(e.target.label)
         {
            case LangConfig.getWord("10392",1):
               UIManager.openVipPanel.visible = true;
               break;
            case LangConfig.getWord("10396",1):
               UIManager.openVipPanel.visible = true;
         }
      }
      
      protected function linkEvent(e:TextEvent) : void
      {
         var i:int = 0;
         switch(e.text)
         {
            case LangConfig.getWord("10397",1):
               this.updata();
               break;
            case LangConfig.getWord("10398",1):
               this.txtGoBack.htmlText = "<u><a href=\"event:" + LangConfig.getWord("10397",1) + "\">" + LangConfig.getWord("10397",1) + "</a></u>";
               this.txtGoBack.y = 159;
               this.back.height = 311;
               this.back.y = 149;
               this.bmVip.y = 159;
               this.txtVipInfo.y = 202;
               i = 3;
               while(Boolean(i--))
               {
                  this.vecTBB[i].visible = true;
               }
               i = 8;
               while(Boolean(i--))
               {
                  this.vecTxtEvent[i].visible = false;
               }
               this.vecTBB[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               this.updataItem();
               if(Boolean(VipVO.level))
               {
                  this.txtGoBack.visible = true;
                  this.txtGoBack.y = 159;
                  break;
               }
               this.txtGoBack.visible = false;
               break;
            case Data_lib.attribute[14][0]:
               VIPCGMessage.CG_GET_VIP_YIQUAN(5);
               break;
            case Data_lib.attribute[18][0]:
               VIPCGMessage.CG_GET_VIP_YIQUAN(1);
               break;
            case LangConfig.getWord("10399",1):
               if(SceneConfig.getSceneType() == SceneConfig.WULIN || SceneConfig.getSceneType() == SceneConfig.BZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.GMD)
               {
                  UIManager.centerBroadcast.addMsg("此场景不能加武魂buff");
                  return;
               }
               VIPCGMessage.CG_GET_VIP_YIQUAN(2);
               break;
            case LangConfig.getWord("10400",1):
               UIManager.depotPanel.visible = true;
               break;
            case LangConfig.getWord("10401",1):
               UIManager.long_way_shop.set_title("YPDIAN",52302);
               UIManager.long_way_shop.visible = true;
               break;
            case LangConfig.getWord("10402",1):
               UIManager.pataOverlordViewPanel.transHandler();
               break;
            case LangConfig.getWord("10403",1):
               if(GameUnitManager.hero.level > 24)
               {
                  UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10404",1));
               break;
            case LangConfig.getWord("10405",1):
               UIManager.smallMap.guClick();
         }
      }
      
      public function removeI(_index:int) : void
      {
         if(kuangVec.length >= 1)
         {
            kuangVec[_index - 1].removeItem();
         }
      }
      
      protected function tbbOnClick(e:MouseEvent) : void
      {
         var tbb:TabButton = e.target as TabButton;
         if(this.curTBB == tbb)
         {
            return;
         }
         if(this.curTBB != null)
         {
            this.curTBB.choose = false;
         }
         tbb.choose = true;
         this.curTBB = tbb;
         this.updataItem();
      }
      
      private function updataItem() : void
      {
         var vo:Vo_item = null;
         if(Boolean(this.curTBB))
         {
            vo = new Vo_item();
            vo.id = this.vecId[this.curTBB.index];
            vo.Init_lib();
            this.txtVipInfo.htmlText = vo.str_describe;
            Utils.getLoadBitmap("resource/image/vip/vip_0" + (3 - this.curTBB.index) + ".png",this.bmVip);
         }
      }
      
      public function updata() : void
      {
         var level:int = 0;
         var vo:Vo_item = null;
         var te:TextEvent = null;
         level = VipVO.level;
         var i:int = 3;
         while(Boolean(i--))
         {
            this.vecTBB[i].visible = false;
         }
         this.txtGoBack.htmlText = "<u><a href=\"event:" + LangConfig.getWord("10398",1) + "\">" + LangConfig.getWord("10398",1) + "</a></u>";
         this.txtGoBack.y = 138;
         this.txtGoBack.visible = true;
         this.back.height = 312;
         this.back.y = 128;
         this.bmVip.y = 138;
         this.txtVipInfo.y = 186;
         i = 6;
         while(Boolean(i--))
         {
            if(i < 3)
            {
               this.vecTxtEvent[i].color = 52224;
            }
            this.vecTxtEvent[i].visible = true;
         }
         this.vecTxtEvent[6].visible = false;
         this.vecTxtEvent[7].visible = false;
         if(Boolean(level))
         {
            this.btnRenewals.y = 87;
            this.btnRenewals.label = LangConfig.getWord("10392",1);
            this.bmVipIcon.visible = true;
            this.txtName.htmlText = LangConfig.getWord("10406",1) + "<font color=\'#5AA8BF\'>" + GameUnitManager.hero.name + "</font>";
            this.txtTime.htmlText = LangConfig.getWord("10407",1,VipVO.days);
            if(Boolean(Global.VIP_Imgsdm))
            {
               this.getBitmap(level);
            }
            vo = new Vo_item();
            vo.id = this.vecId[3 - level];
            vo.Init_lib();
            this.txtVipInfo.htmlText = vo.str_describe;
            if(level == 1)
            {
               if(Boolean(VipVO.data[2]))
               {
                  this.vecTxtEvent[0].color = 10066329;
               }
               if(Boolean(VipVO.data[1]))
               {
                  this.vecTxtEvent[1].color = 10066329;
               }
               this.vecTxtEvent[0].y = 184;
               this.vecTxtEvent[0].htmlText = "<u><a href=\"event:" + Data_lib.attribute[18][0] + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[1].y = 203;
               this.vecTxtEvent[1].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10399",1) + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[2].y = 243 - 5;
               this.vecTxtEvent[2].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10400",1) + "\">" + LangConfig.getWord("10409",1) + "</a></u>";
               this.vecTxtEvent[3].y = 260 - 3;
               this.vecTxtEvent[3].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10401",1) + "\">" + LangConfig.getWord("10409",1) + "</a></u>";
               this.vecTxtEvent[4].y = 279 - 5;
               this.vecTxtEvent[4].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10403",1) + "\">" + LangConfig.getWord("10410",1) + "</a></u>";
               this.vecTxtEvent[5].y = 299 - 7;
               this.vecTxtEvent[5].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10405",1) + "\">" + LangConfig.getWord("10411",1) + "</a></u>";
            }
            else if(level == 2)
            {
               if(Boolean(VipVO.data[0]))
               {
                  this.vecTxtEvent[0].color = 10066329;
               }
               if(Boolean(VipVO.data[1]))
               {
                  this.vecTxtEvent[2].color = 10066329;
               }
               if(Boolean(VipVO.data[2]))
               {
                  this.vecTxtEvent[1].color = 10066329;
               }
               this.vecTxtEvent[0].y = 184;
               this.vecTxtEvent[0].htmlText = "<u><a href=\"event:" + Data_lib.attribute[14][0] + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[1].y = 203;
               this.vecTxtEvent[1].htmlText = "<u><a href=\"event:" + Data_lib.attribute[18][0] + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[2].y = 223;
               this.vecTxtEvent[2].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10399",1) + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[3].y = 260 - 3;
               this.vecTxtEvent[3].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10400",1) + "\">" + LangConfig.getWord("10409",1) + "</a></u>";
               this.vecTxtEvent[4].y = 279 - 5;
               this.vecTxtEvent[4].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10401",1) + "\">" + LangConfig.getWord("10409",1) + "</a></u>";
               this.vecTxtEvent[5].y = 299 - 7;
               this.vecTxtEvent[5].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10403",1) + "\">" + LangConfig.getWord("10410",1) + "</a></u>";
               this.vecTxtEvent[6].visible = true;
               this.vecTxtEvent[6].y = 319 - 9;
               this.vecTxtEvent[6].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10405",1) + "\">" + LangConfig.getWord("10411",1) + "</a></u>";
            }
            else if(level == 3)
            {
               if(Boolean(VipVO.data[0]))
               {
                  this.vecTxtEvent[0].color = 10066329;
               }
               if(Boolean(VipVO.data[1]))
               {
                  this.vecTxtEvent[2].color = 10066329;
               }
               if(Boolean(VipVO.data[2]))
               {
                  this.vecTxtEvent[1].color = 10066329;
               }
               this.vecTxtEvent[0].y = 184;
               this.vecTxtEvent[0].htmlText = "<u><a href=\"event:" + Data_lib.attribute[14][0] + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[1].y = 203;
               this.vecTxtEvent[1].htmlText = "<u><a href=\"event:" + Data_lib.attribute[18][0] + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[2].y = 223;
               this.vecTxtEvent[2].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10399",1) + "\">" + LangConfig.getWord("10408",1) + "</a></u>";
               this.vecTxtEvent[3].y = 260 - 3;
               this.vecTxtEvent[3].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10400",1) + "\">" + LangConfig.getWord("10409",1) + "</a></u>";
               this.vecTxtEvent[4].y = 279 - 5;
               this.vecTxtEvent[4].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10401",1) + "\">" + LangConfig.getWord("10409",1) + "</a></u>";
               this.vecTxtEvent[5].y = 299 - 7;
               this.vecTxtEvent[5].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10402",1) + "\">" + LangConfig.getWord("10312",1) + "</a></u>";
               this.vecTxtEvent[6].visible = true;
               this.vecTxtEvent[6].y = 319 - 9;
               this.vecTxtEvent[6].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10403",1) + "\">" + LangConfig.getWord("10410",1) + "</a></u>";
               this.vecTxtEvent[7].visible = true;
               this.vecTxtEvent[7].y = 339 - 10;
               this.vecTxtEvent[7].htmlText = "<u><a href=\"event:" + LangConfig.getWord("10405",1) + "\">" + LangConfig.getWord("10411",1) + "</a></u>";
            }
         }
         else
         {
            this.bmVipIcon.visible = false;
            this.txtName.htmlText = LangConfig.getWord("10413",1) + "<font color=\'#5AA8BF\'>" + GameUnitManager.hero.name + "</font>";
            this.txtTime.text = LangConfig.getWord("10414",1);
            te = new TextEvent(TextEvent.LINK);
            te.text = LangConfig.getWord("10398",1);
            this.txtGoBack.dispatchEvent(te);
            this.btnRenewals.y = 55;
            this.btnRenewals.label = LangConfig.getWord("10396",1);
         }
      }
      
      private function getBitmap(level:int) : void
      {
         this.bmVipIcon.bitmapData = ComponentUtil.getBitmapData("VIPLv" + level);
         Utils.getLoadBitmap("resource/image/vip/vip_0" + level + ".png",this.bmVip);
         this.bmVip.y = 138;
      }
      
      public function setGray(type:String) : void
      {
         var i:int = int(this.vecTxtEvent.length);
         while(Boolean(i--))
         {
            if(this.vecTxtEvent[i].htmlText.search(type) > -1)
            {
               this.vecTxtEvent[i].color = 10066329;
            }
         }
      }
      
      public function addKuang() : void
      {
         var _ins:SpeEff = null;
         var i:int = 0;
         while(i < 3)
         {
            _ins = SpeEff.getInstance();
            kuangVec.push(_ins);
            i++;
         }
         kuangVec[0].showEff(this.vecTxtEvent[0].x - 6,this.vecTxtEvent[0].y + 1,{
            "width":this.vecTxtEvent[0].width + 7,
            "height":this.vecTxtEvent[0].height
         },this);
         kuangVec[1].showEff(this.vecTxtEvent[1].x - 6,this.vecTxtEvent[1].y + 1,{
            "width":this.vecTxtEvent[1].width + 7,
            "height":this.vecTxtEvent[1].height
         },this);
         kuangVec[2].showEff(this.vecTxtEvent[2].x - 6,this.vecTxtEvent[2].y + 1,{
            "width":this.vecTxtEvent[2].width + 7,
            "height":this.vecTxtEvent[2].height
         },this);
      }
      
      private function removeKuang() : void
      {
         var kk:SpeEff = null;
         for each(kk in kuangVec)
         {
            kk.removeItem();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.bmBack.bitmapData)
            {
               Utils.getLoadBitmap(View_Grid.GRID_OPEN_SKILL_SHENGONG,this.bmBack);
            }
            if(!this.bmHead.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/icon/23" + Enum_job.getBaseJob(GameUnitManager.hero.job) + 1 + GameUnitManager.hero.sex + ".jpg",this.bmHead);
            }
            this.updata();
            VIPCGMessage.CG_VIP_OPEN();
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_VIP);
            }
            if(canAddK)
            {
               if(GameUnitManager.hero.vip > 0)
               {
                  this.addKuang();
               }
               else if(GameUnitManager.hero.vip == 0)
               {
                  this.removeKuang();
               }
               canAddK = false;
            }
            if(!Global.VIP_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.sourceComplete();
            }
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_Vip.VIPSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.VIP_Imgsdm = info.applicationDomain;
         }
         this.titleBg = ComponentUtil.getBitmap("Title_WuHun",this,{
            "x":120,
            "y":5
         },Global.VIP_Imgsdm);
         if(!this.bmVipIcon.bitmapData && Boolean(VipVO.level))
         {
            this.getBitmap(VipVO.level);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

