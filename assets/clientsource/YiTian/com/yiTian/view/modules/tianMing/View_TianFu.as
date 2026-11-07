package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_OtherTip_Type;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.TianMingHandler;
   import com.yiTian.net.message.cg.TianMingCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class View_TianFu extends Sprite
   {
      
      private static var _instance:View_TianFu;
      
      private const START_POINT_1:Point = new Point(470 - 17,50 + 83);
      
      private const START_POINT_2:Point = new Point(185 + 125,173 + 80);
      
      private const END_POINT:Point = new Point(94 + 37,17 + 75);
      
      private var itemVec:Vector.<TianFu_Item>;
      
      private var upChanceTF:MyTextField;
      
      private var tianFuZFLevTF:MyTextField;
      
      private var tianFuLevTF:MyTextField;
      
      public var tianFu_bar:ProgressBar;
      
      private var accept_btn:Button;
      
      private var itemVo:Vo_item;
      
      private var itemGrid:View_Grid;
      
      private var itemNum:int;
      
      private var moneyNum:int;
      
      private var costTF:MyTextField;
      
      private var tzObj:Object;
      
      private var tzBm:Bitmap;
      
      public function View_TianFu()
      {
         super();
         this.init();
      }
      
      public static function get instance() : View_TianFu
      {
         if(!_instance)
         {
            _instance = new View_TianFu();
         }
         return _instance;
      }
      
      public function addFly(type:int) : void
      {
         var startPoint:Point = null;
         var endPoint:Point = null;
         if(type == 1)
         {
            startPoint = this.START_POINT_1;
            endPoint = new Point(20 + this.tianFu_bar.barWidth,275);
         }
         else if(type == 2)
         {
            startPoint = this.START_POINT_2;
            endPoint = this.END_POINT;
         }
         var eff:Effect = EffectManager.addEffect("35040",this,23 * 50,startPoint.x,startPoint.y,false);
         setTimeout(this.fly,7 * 50,eff,startPoint,endPoint);
      }
      
      private function fly(eff:Effect, startPoint:Point, endPoint:Point) : void
      {
         Tween.to(eff,10 * 50,{
            "px":[startPoint.x,endPoint.x],
            "py":[startPoint.y,endPoint.y]
         });
      }
      
      private function init() : void
      {
         this.creatItem();
         this.initInfo();
      }
      
      private function creatItem() : void
      {
         var item:TianFu_Item = null;
         this.itemVec = new Vector.<TianFu_Item>();
         var i:int = 0;
         while(i < 2)
         {
            item = new TianFu_Item();
            item.x = 18 + 170 * i;
            item.y = 17;
            this.addChild(item);
            this.itemVec.push(item);
            i++;
         }
      }
      
      private function initInfo() : void
      {
         this.creat();
      }
      
      private function creat() : void
      {
         this.getTZ();
         this.getItem();
         this.creatTF();
         this.tianFu_bar = new ProgressBar();
         addChild(this.tianFu_bar);
         ComponentUtil.setPropertie(this.tianFu_bar,{
            "x":5,
            "y":198
         });
         var upTianFu_btn:Button = ComponentUtil.getButton(LangConfig.getWord("80077",8),"Button_Four",this,{
            "x":533 - 34,
            "y":391 - 290,
            "textColor":16184781
         },Global.Img_Cdm);
         this.accept_btn = ComponentUtil.getButton(LangConfig.getWord("80078",8),"Button_Orange",this,{
            "x":550 - 34,
            "y":468 - 290 + 20,
            "textColor":16184781
         },Global.Img_Cdm);
         upTianFu_btn.callBack = this.upFun;
         this.accept_btn.callBack = this.acceptFun;
      }
      
      private function changButton(canClick:Boolean) : void
      {
         if(canClick)
         {
            this.accept_btn.enabled = true;
            this.accept_btn.label = LangConfig.getWord("80078",8);
         }
         else
         {
            this.accept_btn.enabled = false;
            this.accept_btn.label = LangConfig.getWord("80118",8);
         }
      }
      
      public function upDataItem() : void
      {
         var count:int = CommandManager.get_bag_count(46574);
         this.itemVo.count = count;
         this.itemGrid.vo = this.itemVo;
      }
      
      private function acceptFun(event:MouseEvent) : void
      {
         if(Model_Tianming.tianFuLevel >= Enum_TianMing.TIANFU_MAXLEVEL)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80079",8));
         }
         else if(Model_Tianming.zhuFuLevel > Model_Tianming.tianFuLevel)
         {
            TianMingCGMessage.CG_UP_ZHUFU();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80080",8));
         }
      }
      
      private function upFun(event:MouseEvent) : void
      {
         if(Model_Tianming.tianFuLevel >= Enum_TianMing.TIANFU_MAXLEVEL)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80079",8));
         }
         else if(this.itemGrid.vo.count < this.itemNum)
         {
            TianMingHandler.goToShop();
         }
         else
         {
            TianMingCGMessage.CG_UP_TIANFU();
         }
      }
      
      public function upZhuFuInfo(level:int, exp:int) : void
      {
         Model_Tianming.zhuFuLevel = level;
         Model_Tianming.zhuFuExp = exp;
         this.tianFuZFLevTF.htmlText = LangConfig.getWord("80083",8,level);
         var maxExp:int = level < Enum_TianMing.ZHUFU_MAXLEVEL ? int(Data_lib.tmzf[level + 1][0]) : int(Data_lib.tmzf[level][0]);
         this.tianFu_bar.upData(exp,maxExp);
         this.changButton(Model_Tianming.zhuFuLevel > Model_Tianming.tianFuLevel);
      }
      
      public function upTianFuInfo() : void
      {
         var item:TianFu_Item = null;
         var level:int = Model_Tianming.tianFuLevel;
         this.tzObj.level = level >= 10 ? level : 10;
         var i:int = 0;
         while(i < 2)
         {
            item = this.itemVec[i];
            item.show(Model_Tianming.myTianMing,level + i);
            i++;
         }
         this.changUpInfo();
         this.upDataBm();
         this.changButton(Model_Tianming.zhuFuLevel > Model_Tianming.tianFuLevel);
      }
      
      private function upDataBm() : void
      {
         var level:int = Model_Tianming.tianFuLevel;
         var id:int = Math.floor(level / 10);
         var url:String = "resource/image/tianMing/tz_" + id + ".png";
         this.tzBm = Utils.getLoadBitmap(url,this.tzBm);
      }
      
      private function changUpInfo() : void
      {
         var level:int = Model_Tianming.tianFuLevel;
         this.tianFuLevTF.htmlText = LangConfig.getWord("80113",8) + "  " + "<font color=\'#0099FF\' size=\'14\'>" + level + "</font>";
         if(level == 40)
         {
            this.upChanceTF.text = "00%";
            this.costTF.text = "X0  " + LangConfig.getWord("80084",8) + "0";
            return;
         }
         var chance:String = Data_lib.tmsx[level][0] + "%";
         this.upChanceTF.text = chance;
         this.itemNum = 1;
         this.moneyNum = Data_lib.tmsx[level][1];
         this.costTF.htmlText = "X" + this.itemNum + "  " + "<font color =\'#0099FF\'>" + LangConfig.getWord("80084",8) + this.moneyNum + "</font>";
      }
      
      private function getItem() : void
      {
         this.itemVo = new Vo_item();
         this.itemVo.id = 46574;
         this.itemVo.Init_lib();
         this.itemGrid = new View_Grid();
         this.itemGrid.type = Enum_type_grid.NO_DRAG;
         this.itemGrid.isAutoLoad = true;
         this.itemGrid.set_bmp_bg();
         this.itemGrid.set_bmp_over();
         this.itemGrid.set_tf_count(true,true,true);
         addChild(this.itemGrid);
         ComponentUtil.setPropertie(this.itemGrid,{
            "x":470 - 34,
            "y":50
         });
         this.upDataItem();
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.upDataItem);
      }
      
      private function creatTF() : void
      {
         var tip:MyTextField = ComponentUtil.getTextField("",this,{
            "x":400 - 34,
            "y":419 - 290,
            "color":14662240,
            "size":12,
            "leading":0
         });
         tip.multiline = true;
         tip.htmlText = LangConfig.getWord("80085",8);
         ComponentUtil.getTextField(LangConfig.getWord("80086",8),this,{
            "x":470,
            "y":303 - 290,
            "color":16763904,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80087",8),this,{
            "x":400 - 34,
            "y":348 - 290,
            "color":16763904,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80088",8),this,{
            "x":400 - 34,
            "y":394 - 290,
            "color":16763904,
            "size":12,
            "leading":0
         });
         this.upChanceTF = ComponentUtil.getTextField("00%",this,{
            "x":472 - 34,
            "y":394 - 290,
            "color":39423,
            "size":12,
            "leading":0
         });
         this.tianFuZFLevTF = ComponentUtil.getTextField("",this,{
            "x":185,
            "y":173,
            "color":16764206,
            "size":16,
            "leading":0
         });
         this.tianFuLevTF = ComponentUtil.getTextField("",this,{
            "x":400 - 34,
            "y":303 - 292,
            "color":16763904,
            "size":12,
            "leading":0,
            "mouseEnabled":true
         });
         TipManager.bind(this.tianFuLevTF,LangConfig.getWord("80112",8));
         this.costTF = ComponentUtil.getTextField("X 00",this,{
            "x":522 - 45,
            "y":355 - 290,
            "color":16764206,
            "size":14,
            "leading":0
         });
      }
      
      private function getTZ() : void
      {
         var str_icon:String;
         var sprite:Sprite = null;
         this.tzObj = {"typeId":Enum_OtherTip_Type.TIANMING};
         str_icon = "resource/image/icon/20907_40.jpg";
         this.tzBm = new Bitmap();
         sprite = new Sprite();
         sprite.addChild(this.tzBm);
         this.addChild(sprite);
         sprite.x = 525;
         sprite.y = 0;
         sprite.addEventListener(MouseEvent.ROLL_OVER,this.roll_over);
         sprite.addEventListener(MouseEvent.ROLL_OUT,function():void
         {
            TipManager.hide();
         });
      }
      
      private function roll_over(event:MouseEvent) : void
      {
         if(Model_Tianming.tianFuLevel == 0)
         {
            return;
         }
         TipManager.update(this.tzObj);
      }
   }
}

