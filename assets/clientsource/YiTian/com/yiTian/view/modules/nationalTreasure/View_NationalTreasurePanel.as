package com.yiTian.view.modules.nationalTreasure
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.NationalTreasureCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_NationalTreasurePanel extends Panel123
   {
      
      private var bg:DisplayObject;
      
      private var itemOrdinaryShowVec:Vector.<Child_ShowItem> = new Vector.<Child_ShowItem>(Enum_NationalTreasure.SHOW_MAX_NUM,true);
      
      private var itemAdvancedShowVec:Vector.<Child_ShowItem> = new Vector.<Child_ShowItem>(Enum_NationalTreasure.SHOW_MAX_NUM,true);
      
      private var gridVec:Vector.<Child_GridItem> = new Vector.<Child_GridItem>(Enum_NationalTreasure.WABAO_MAX_NUM,true);
      
      private var listVec:Vector.<Child_ListItem> = new Vector.<Child_ListItem>(Enum_NationalTreasure.BROADCAST_MAX_NUM,true);
      
      private var textJifen:MyTextField;
      
      private var textArea:MyTextField;
      
      private var textAreaDes:MyTextField;
      
      private var textRefresh:MyTextField;
      
      private var textRule:MyTextField;
      
      private var btnRefresh:Button;
      
      private var btnDuihuan:Button;
      
      private var btnOrdinary:Button;
      
      private var btnAdvanced:Button;
      
      private var btnOrdinaryLeft:Button;
      
      private var btnAdvancedRight:Button;
      
      private var btnOverIcon:Bitmap;
      
      private var btnPos:Array = [67,126];
      
      private var isInitAdvanced:Boolean;
      
      public function View_NationalTreasurePanel()
      {
         super();
         regResource("lang/ch/WaBao_Imgs.swf","WaBaodm");
      }
      
      public static function get instance() : View_NationalTreasurePanel
      {
         return Singleton.getInstance(View_NationalTreasurePanel);
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":911,
            "height":595
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_WaBao",[18,23,1,1],this,{
            "x":20,
            "y":81,
            "width":872,
            "height":503
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Back_CW",[10,14,1,470],this,{
            "x":672,
            "y":87,
            "width":207,
            "height":493
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Back_R1",[14,15,1,1],this,{
            "x":669,
            "y":84,
            "width":214,
            "height":227
         },Global.WaBaodm);
         ComponentUtil.getBitmap("Title_QFWB",this,{
            "x":376,
            "y":6
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Back_R1",[14,15,1,1],this,{
            "x":669,
            "y":333,
            "width":214,
            "height":248
         },Global.WaBaodm);
         ComponentUtil.getBitmap("Text_DQWZ",this,{
            "x":202,
            "y":53
         },Global.WaBaodm);
         ComponentUtil.getBitmap("BG_FaGuang",this,{
            "x":294,
            "y":50
         },Global.WaBaodm);
         ComponentUtil.getTextField("如数据延迟请点击",this,{
            "x":478,
            "y":59,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_R1",[14,15,1,1],this,{
            "x":29,
            "y":84,
            "width":637,
            "height":497
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Back_FaGuang",[1,4,186,1],this,{
            "x":32,
            "y":488,
            "width":631,
            "height":81
         },Global.WaBaodm);
         ComponentUtil.getTextField("点击进行挖宝",this,{
            "x":81,
            "y":510,
            "color":13816530,
            "size":16,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_FGG",[5,5,1,1],this,{
            "x":43,
            "y":499,
            "width":36,
            "height":36
         },Global.WaBaodm);
         ComponentUtil.getBitmap("0_78",this,{
            "x":44,
            "y":500,
            "width":34,
            "height":34
         },Global.WaBaodm);
         ComponentUtil.getBitmap("Text_WDJF",this,{
            "x":416,
            "y":497
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":503,
            "y":498,
            "width":74,
            "height":20
         },Global.Img_Cdm);
         this.textRule = ComponentUtil.getTextField("",this,{
            "x":503,
            "y":530,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("挖完一片挖宝区的所有宝藏，挖宝区重新刷新！",this,{
            "x":203,
            "y":551,
            "color":6737734,
            "size":14,
            "leading":0
         });
         ComponentUtil.getBitmap("BG_ZBGCW",this,{
            "x":672,
            "y":56
         },Global.WaBaodm);
         ComponentUtil.getBitmap("BG_ZBGCW",this,{
            "x":672,
            "y":305
         },Global.WaBaodm);
         ComponentUtil.getBitmap("Text_ZBG",this,{
            "x":734,
            "y":52
         },Global.WaBaodm);
         ComponentUtil.getBitmap("Text_ChuanWen",this,{
            "x":751,
            "y":304
         },Global.WaBaodm);
         ComponentUtil.getBitmap("BG_FaGuang",this,{
            "x":703,
            "y":81
         },Global.WaBaodm);
         ComponentUtil.getBitmap("BG_FaGuang",this,{
            "x":703,
            "y":189
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Back_B1",[5,5,1,1],this,{
            "x":681,
            "y":107,
            "width":190,
            "height":90
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Back_B1",[5,5,1,1],this,{
            "x":681,
            "y":217,
            "width":190,
            "height":90
         },Global.WaBaodm);
         ComponentUtil.getTextField("普通挖宝区珍宝",this,{
            "x":726,
            "y":87,
            "color":15788617,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("高级挖宝区珍宝",this,{
            "x":726,
            "y":196,
            "color":15788617,
            "size":14,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_B1",[5,5,1,1],this,{
            "x":681,
            "y":338,
            "width":190,
            "height":148
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Back_B2",[17,18,1,1],this,{
            "x":672,
            "y":488,
            "width":207,
            "height":96
         },Global.WaBaodm);
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":688,
            "y":503,
            "color":13816530,
            "size":12,
            "leading":2,
            "realWidth":183,
            "wordWrap":true
         });
         tf.htmlText = "注:<font color = \'#f9ff00\'>普通挖宝区</font>需要消耗<font color = \'#f9ff00\'>普通挖宝钥匙</font>,<font color = \'#f9ff00\'>高级挖宝区</font>需要消耗<font color = \'#f9ff00\'>高级挖宝钥匙</font>\n<font color = \'#04ff00\'>钥匙来源：倚天必做奖励中产出</font> ";
         tf.mouseEnabled = true;
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":874,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.textRule.htmlText = "<font><u>查看积分规则</u></font>";
         this.textRule.mouseEnabled = true;
         TipManager.bind(this.textRule,"普通挖宝区挖宝一次，可获得10点积分<br/>高级挖宝区挖宝一次，可获得50点积分<br/><font color=\'#33CCFF\'>积分可累计，用于兑换珍宝</font>");
         this.btnOrdinary = ComponentUtil.getButton("","Button_PTWB",this,{
            "x":28,
            "y":37,
            "textColor":16771436
         },Global.WaBaodm);
         this.btnAdvanced = ComponentUtil.getButton("","Button_GJWB",this,{
            "x":120,
            "y":36,
            "textColor":16771436
         },Global.WaBaodm);
         this.btnDuihuan = ComponentUtil.getButton("","Button_Four",this,{
            "x":587,
            "y":497,
            "textColor":16771436
         },Global.Img_Cdm);
         this.btnRefresh = ComponentUtil.getButton("","Button_Four",this,{
            "x":587,
            "y":56,
            "textColor":16771436
         },Global.Img_Cdm);
         this.textRefresh = ComponentUtil.getTextField("刷新",this,{
            "x":608,
            "y":59,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.textJifen = ComponentUtil.getTextField("2222222",this,{
            "x":513,
            "y":499,
            "color":13816530,
            "size":12,
            "leading":0
         });
         this.textArea = ComponentUtil.getTextField("高级挖宝区",this,{
            "x":327,
            "y":55,
            "color":16776960,
            "size":16,
            "leading":0,
            "bold":true
         });
         this.textAreaDes = ComponentUtil.getTextField("(此区域挖宝需消耗高级挖宝钥匙) ",this,{
            "x":182,
            "y":513,
            "color":13816530,
            "size":12,
            "leading":0
         });
         this.btnOverIcon = ComponentUtil.getBitmap("FaGuang2",this,{
            "x":67,
            "y":42
         },Global.WaBaodm);
         ComponentUtil.getTextField("兑换珍宝",this,{
            "x":597,
            "y":499,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.initEvent();
         Model_NationalTreasure.setItemOrdinaryShowData();
         Model_NationalTreasure.setItemAdvancedShowData();
         this.createShowList(this.itemOrdinaryShowVec,Model_NationalTreasure.itemOrdinaryShowData,690,111);
         this.createShowList(this.itemAdvancedShowVec,Model_NationalTreasure.itemAdvancedShowData,690,222);
         this.createGridList();
      }
      
      private function initEvent() : void
      {
         this.btnOrdinary.addEventListener(MouseEvent.CLICK,this.onOrdinary);
         this.btnAdvanced.addEventListener(MouseEvent.CLICK,this.onAdvanced);
         this.btnDuihuan.addEventListener(MouseEvent.CLICK,this.onDuihuan);
         this.btnRefresh.addEventListener(MouseEvent.CLICK,this.onRefresh);
      }
      
      private function onOrdinary(e:MouseEvent) : void
      {
         this.update(Enum_NationalTreasure.ORDINARY_AREA);
         NationalTreasureCGMessage.CG_CHANGE_PAGE(Enum_NationalTreasure.ORDINARY_AREA);
      }
      
      private function onAdvanced(e:MouseEvent) : void
      {
         if(!this.isInitAdvanced || !Global.WaBaodm2)
         {
            this.load();
         }
         else
         {
            this.update(Enum_NationalTreasure.ADVANCED_AREA);
            NationalTreasureCGMessage.CG_CHANGE_PAGE(Enum_NationalTreasure.ADVANCED_AREA);
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push(["lang/ch/WaBao_Imgs2.swf",this.onComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function onComplete(info:Object) : void
      {
         Global.WaBaodm2 = info.applicationDomain;
         this.isInitAdvanced = true;
         this.update(Enum_NationalTreasure.ADVANCED_AREA);
         NationalTreasureCGMessage.CG_CHANGE_PAGE(Enum_NationalTreasure.ADVANCED_AREA);
      }
      
      private function onDuihuan(e:MouseEvent) : void
      {
         Global.delegate.dosomething(View_IntegrationShopPanel.instance,View_IntegrationShopPanel.instance.show);
      }
      
      private function onRefresh(e:MouseEvent) : void
      {
         NationalTreasureCGMessage.CG_CHANGE_PAGE(Model_NationalTreasure.currentArea);
      }
      
      private function update(area:int) : void
      {
         Model_NationalTreasure.currentArea = area;
         this.btnOverIcon.x = this.btnPos[area];
         this.textArea.text = Model_NationalTreasure.AreaData[area] + "挖宝区";
         this.textAreaDes.text = "(此区域挖宝需消耗" + Model_NationalTreasure.AreaData[area] + "挖宝钥匙) ";
      }
      
      private function setBtnVisible(value:Boolean) : void
      {
         this.btnOrdinaryLeft.visible = value;
         this.btnAdvancedRight.visible = !value;
      }
      
      private function createShowList(itemShowVec:Vector.<Child_ShowItem>, data:Array, x:int, y:int) : void
      {
         var item:Child_ShowItem = null;
         var i:int = 0;
         i = 0;
         while(i < Enum_NationalTreasure.SHOW_MAX_NUM)
         {
            item = new Child_ShowItem();
            item.x = x + i % 4 * 44;
            item.y = y + int(i / 4) * 42;
            addChild(item);
            itemShowVec[i] = item;
            if(i < data.length)
            {
               item.Vo = data[i];
            }
            i++;
         }
      }
      
      private function createGridList() : void
      {
         var item:Child_GridItem = null;
         var i:int = 0;
         i = 0;
         while(i < Enum_NationalTreasure.WABAO_MAX_NUM)
         {
            item = new Child_GridItem();
            item.x = 40 + i % Enum_NationalTreasure.COL_NUM * 44;
            item.y = 95 + int(i / Enum_NationalTreasure.COL_NUM) * 44;
            addChild(item);
            this.gridVec[i] = item;
            i++;
         }
      }
      
      public function showGridList(data:Array) : void
      {
         var i:int = 0;
         if(!data || !data.length)
         {
            return;
         }
         var len:int = Enum_NationalTreasure.WABAO_MAX_NUM;
         i = 0;
         while(i < len)
         {
            if(Boolean(this.gridVec[i]))
            {
               this.gridVec[i].setGridBmd(Model_NationalTreasure.currentArea,i);
               this.gridVec[i].setVo(data[i],Model_NationalTreasure.currentArea,i);
            }
            i++;
         }
      }
      
      public function showBroadcastList(data:Array) : void
      {
         var i:int = 0;
         var item:Child_ListItem = null;
         if(!data || !data.length)
         {
            return;
         }
         var len:int = data.length > Enum_NationalTreasure.BROADCAST_MAX_NUM ? Enum_NationalTreasure.BROADCAST_MAX_NUM : int(data.length);
         i = 0;
         while(i < len)
         {
            if(Boolean(this.listVec[i]))
            {
               this.listVec[i].update(data[i]);
            }
            else
            {
               item = new Child_ListItem();
               addChild(item);
               item.update(data[i]);
               item.x = 688;
               item.y = 342 + i * item.height;
               this.listVec[i] = item;
            }
            i++;
         }
      }
      
      public function setGridVisible(value:Boolean, i:int) : void
      {
         if(Boolean(this.gridVec[i]))
         {
            this.gridVec[i].setBgVisible(value);
         }
      }
      
      public function setJifen(jifen:int) : void
      {
         if(!this.textJifen)
         {
            return;
         }
         this.textJifen.text = jifen + "";
      }
      
      public function show(prm:* = null) : void
      {
         visible = true;
         this.update(Enum_NationalTreasure.ORDINARY_AREA);
         NationalTreasureCGMessage.CG_WABAO_DATA();
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
      
      public function showFlyIcon(i:int) : void
      {
         var item:Child_GridItem = this.gridVec[i];
         if(Boolean(item))
         {
            item.flyIcon();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 911) / 2;
         y = (Global.stage.stageHeight - 595) / 2;
      }
   }
}

