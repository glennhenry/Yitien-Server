package com.yiTian.view.modules.fishing
{
   import Layout.GridGroup;
   import Layout.ILayout;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.IBindViewer;
   import com.yiTian.data.config.Enum_fishing;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_riverChoose extends Panel implements IBindViewer
   {
      
      public static const MAX_PLAYER:int = 25;
      
      public static const NUMPERPAGE:int = 18;
      
      private var buttonVec:Vector.<Btnn>;
      
      private var buttonVec2:Vector.<Btnn>;
      
      private var bg:ScaleBitmap;
      
      private var titleBg:Bitmap;
      
      private var pageIndex1:int = 0;
      
      public var pageIndex2:int = 0;
      
      private var btnPre1:Button;
      
      private var btnNxt1:Button;
      
      private var tfPage1:MyTextField;
      
      private var btnPre2:Button;
      
      private var btnNxt2:Button;
      
      private var tfPage2:MyTextField;
      
      private var changeTimeFlag:int = -3000;
      
      public function View_riverChoose()
      {
         super();
      }
      
      private function createButton(count:int) : void
      {
         var g1:ILayout = null;
         var g2:ILayout = null;
         var btn_river:Btnn = null;
         var btn_beach:Btnn = null;
         g1 = new GridGroup(100,52,0,0,0,73,0,103,6);
         this.buttonVec = new Vector.<Btnn>();
         var index:int = 0;
         while(index < count)
         {
            btn_river = new Btnn("","Button_HeWan",Global.Fishing_Imgsdm);
            addChild(btn_river);
            btn_river.name = "-1";
            btn_river.tabIndex = index + 1;
            btn_river.labelTF.align = "center";
            btn_river.icon.bitmapData = ComponentUtil.getBitmapData("YuLanImg",Global.Fishing_Imgsdm);
            btn_river.callBack = this.clickHandle;
            g1.appendItem(btn_river);
            this.buttonVec.push(btn_river);
            index++;
         }
         g1.align();
         g2 = new GridGroup(100,309,0,0,0,73,0,103,6);
         this.buttonVec2 = new Vector.<Btnn>();
         while(index < NUMPERPAGE * 2)
         {
            btn_beach = new Btnn("","Button_HaiTan",Global.Fishing_Imgsdm);
            addChild(btn_beach);
            btn_beach.name = "-2";
            btn_beach.tabIndex = index + 1;
            btn_beach.labelTF.align = "center";
            btn_beach.icon.bitmapData = ComponentUtil.getBitmapData("YuLanImg",Global.Fishing_Imgsdm);
            btn_river.callBack = this.clickHandle;
            g2.appendItem(btn_beach);
            this.buttonVec2.push(btn_beach);
            index += 1;
         }
         g2.align();
         g1.dispose();
         g2.dispose();
         this.btnPre1 = ComponentUtil.getButton(LangConfig.getWord("80069",8),"Button_Orange",this,{
            "x":285,
            "y":272,
            "callBack":this.p1ClickHd
         },Global.Img_Cdm);
         this.btnNxt1 = ComponentUtil.getButton(LangConfig.getWord("80070",8),"Button_Orange",this,{
            "x":458,
            "y":272,
            "callBack":this.n1ClickHd
         },Global.Img_Cdm);
         this.tfPage1 = ComponentUtil.getTextField("1/2",this,{
            "x":407,
            "y":275,
            "realWidth":0
         });
         this.tfPage1.autoSize = TextFieldAutoSize.CENTER;
         this.btnPre2 = ComponentUtil.getButton(LangConfig.getWord("80069",8),"Button_Orange",this,{
            "x":285,
            "y":531,
            "callBack":this.p2ClickHd
         },Global.Img_Cdm);
         this.btnNxt2 = ComponentUtil.getButton(LangConfig.getWord("80070",8),"Button_Orange",this,{
            "x":458,
            "y":531,
            "callBack":this.n2ClickHd
         },Global.Img_Cdm);
         this.tfPage2 = ComponentUtil.getTextField("1/5",this,{
            "x":407,
            "y":534,
            "realWidth":0
         });
         this.tfPage2.autoSize = TextFieldAutoSize.CENTER;
      }
      
      private function p1ClickHd(e:MouseEvent) : void
      {
         this.setPage1(this.pageIndex1 - 1);
      }
      
      private function n1ClickHd(e:MouseEvent) : void
      {
         this.setPage1(this.pageIndex1 + 1);
      }
      
      private function p2ClickHd(e:MouseEvent) : void
      {
         this.setPage2(this.pageIndex2 - 1);
      }
      
      private function n2ClickHd(e:MouseEvent) : void
      {
         this.setPage2(this.pageIndex2 + 1);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.pageIndex2 = 0;
            if(!Global.Fishing_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.sourceComplete();
            }
            FishingCGMessage.CG_FISH_ROOM();
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_fishing.FISHINGSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.Fishing_Imgsdm = info.applicationDomain;
         }
         this.titleBg = ComponentUtil.getBitmap("Title_HeWan",this,{
            "x":295,
            "y":5
         },Global.Fishing_Imgsdm);
         ComponentUtil.getBitmap("Back_HeWan",this,{
            "x":29,
            "y":45
         },Global.Fishing_Imgsdm);
         ComponentUtil.getBitmap("Back_HaiTan",this,{
            "x":29,
            "y":304
         },Global.Fishing_Imgsdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":366,
            "y":273,
            "width":80,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":366,
            "y":532,
            "width":80,
            "height":24
         },Global.Img_Cdm);
         this.createButton(18);
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":750,
            "height":573
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":702,
            "height":523
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":714,
            "y":6
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         Model_fishing.getInstance().fishRoomInfo.setBindViewer(this);
      }
      
      public function update(obj:Object) : void
      {
         var num:int = 0;
         var btn:Btnn = null;
         var arrIndex:int = 0;
         var idStr:String = null;
         var arr:Array = obj as Array;
         var i:int = 0;
         i = 0;
         while(i < NUMPERPAGE)
         {
            arrIndex = i + this.pageIndex1 * NUMPERPAGE;
            num = int(arr[arrIndex]);
            btn = this.buttonVec[i];
            idStr = Enum_BroadCastTool.instance.getBitStr(i + 1 + this.pageIndex1 * NUMPERPAGE);
            if(num <= 0)
            {
               btn.setTxt2(LangConfig.getWord("29098",2));
               btn.enabled = true;
            }
            else if(num < MAX_PLAYER)
            {
               btn.setTxt2("<font color=\'#33FF33\'>" + LangConfig.getWord("29419",2,num,MAX_PLAYER) + "</font>");
               btn.enabled = true;
            }
            else
            {
               btn.setTxt2(LangConfig.getWord("29099",2));
               btn.enabled = false;
            }
            btn.setTxt1(LangConfig.getWord("29418",2,idStr));
            i += 1;
         }
         i = 0;
         while(i < NUMPERPAGE)
         {
            arrIndex = i + NUMPERPAGE * 2 + this.pageIndex2 * NUMPERPAGE;
            num = int(arr[arrIndex]);
            btn = this.buttonVec2[i];
            idStr = Enum_BroadCastTool.instance.getBitStr(i + 1 + this.pageIndex2 * NUMPERPAGE);
            if(num <= 0)
            {
               btn.setTxt2(LangConfig.getWord("29098",2));
               btn.enabled = true;
            }
            else if(num < MAX_PLAYER)
            {
               btn.setTxt2("<font color=\'#33FF33\'>" + LangConfig.getWord("29419",2,num,MAX_PLAYER) + "</font>");
               btn.enabled = true;
            }
            else
            {
               btn.setTxt2(LangConfig.getWord("29099",2));
               btn.enabled = false;
            }
            btn.setTxt1(LangConfig.getWord("29418",2,idStr));
            i += 1;
         }
         this.tfPage2.text = (this.pageIndex2 + 1).toString() + "/" + Model_fishing.getInstance().roomMaxPage2;
      }
      
      public function setPage1(v:int) : void
      {
         var data:Object = Model_fishing.getInstance().fishRoomInfo.getData();
         if(!data || v < 0 || v > Model_fishing.getInstance().roomMaxPage - 1)
         {
            return;
         }
         this.pageIndex1 = v;
         this.tfPage1.text = (v + 1).toString() + "/" + Model_fishing.getInstance().roomMaxPage;
         this.update(data);
      }
      
      public function setPage2(v:int) : void
      {
         var data:Object = Model_fishing.getInstance().fishRoomInfo.getData();
         if(!data || v < 0 || v > Model_fishing.getInstance().roomMaxPage2 - 1)
         {
            return;
         }
         this.pageIndex2 = v;
         this.tfPage2.text = (v + 1).toString() + "/" + Model_fishing.getInstance().roomMaxPage2;
         this.update(data);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         var ti:int = 0;
         var type:int = 0;
         var senCGIndex:int = 0;
         var ins:Model_fishing = null;
         var now:int = 0;
         evt.stopPropagation();
         if(evt.target is Btnn)
         {
            ti = int(evt.target.tabIndex);
            type = ti <= NUMPERPAGE ? 1 : 2;
            senCGIndex = type == 1 ? int(this.pageIndex1 * NUMPERPAGE + ti) : int(NUMPERPAGE + NUMPERPAGE * this.pageIndex2 + ti);
            ins = Model_fishing.getInstance();
            if(senCGIndex != -1)
            {
               if(GameUnitManager.hero.status == Status.FISH)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("23333",2));
               }
               else if(ins.currentRiverId == senCGIndex)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("23334",2));
               }
               else
               {
                  now = getTimer();
                  if(now - this.changeTimeFlag <= 3000)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23335",2));
                     return;
                  }
                  if(type == 1 || type == 2 && GameUnitManager.hero.level >= 75)
                  {
                     FishingCGMessage.CG_ENTER_RIVER(senCGIndex);
                     this.changeTimeFlag = now;
                     this.visible = false;
                     this.changeTimeFlag = now;
                  }
                  else
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("22404",2));
                  }
               }
            }
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import flash.display.Bitmap;
import flash.system.ApplicationDomain;
import flash.text.TextFieldAutoSize;

class Btnn extends Button
{
   
   public var icon:Bitmap;
   
   private var tf1:MyTextField;
   
   private var tf2:MyTextField;
   
   public function Btnn(txt:String, style:String, dm:ApplicationDomain)
   {
      super(txt,style,dm);
      this.icon = new Bitmap();
      addChild(this.icon);
      this.tf1 = ComponentUtil.getTextField("",this,{
         "x":60,
         "y":12,
         "color":16755200,
         "size":14
      });
      this.tf2 = ComponentUtil.getTextField("",this,{
         "x":49,
         "y":44
      });
      this.tf2.autoSize = TextFieldAutoSize.CENTER;
   }
   
   public function setTxt1(v:String) : void
   {
      this.tf1.htmlText = v;
   }
   
   public function setTxt2(v:String) : void
   {
      this.tf2.htmlText = v;
   }
}
