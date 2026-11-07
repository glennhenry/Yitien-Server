package com.yiTian.view.modules.wing
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WingCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.geom.Rectangle;
   
   public class View_wing_buyGuide extends Panel
   {
      
      private static var _instance:View_wing_buyGuide;
      
      private var buyBtn1:Button;
      
      private var buyBtn2:Button;
      
      private var btn2Effect:Effect;
      
      private var curShow:Child_tianTiUnit;
      
      private var nextShow:Child_tianTiUnit;
      
      private const leftLevel:int = 1;
      
      private const rightLevel:int = 4;
      
      public function View_wing_buyGuide()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         super.init();
      }
      
      public static function get instance() : View_wing_buyGuide
      {
         if(!_instance)
         {
            _instance = new View_wing_buyGuide();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var curAttribute:Array;
         var currentAttributeArray:Array;
         var i:* = undefined;
         var nextAttribute:Array = null;
         var nextAttributeArray:Array = null;
         var j:* = undefined;
         var increaseStr:String = null;
         var totalString:String = null;
         var k:* = undefined;
         var l:* = undefined;
         var id:* = undefined;
         var id2:* = undefined;
         move = new Rectangle(0,0,528,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":528,
            "height":389
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":478,
            "height":339
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":74,
            "width":454,
            "height":293
         },Global.ChiBangdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":494,
            "y":5,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXTS",this,{
            "x":184,
            "y":6
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Frame_RWCB",this,{
            "x":44,
            "y":81
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Frame_RWCB",this,{
            "x":279,
            "y":81
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Light_CBMC",this,{
            "x":70,
            "y":293
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Light_CBMC",this,{
            "x":305,
            "y":293
         },Global.ChiBangdm);
         this.curShow = new Child_tianTiUnit();
         addChild(this.curShow);
         this.curShow.x = 167;
         this.curShow.y = 280;
         this.curShow.way = 3;
         this.curShow.type = Child_tianTiUnit.PLAYER;
         this.curShow.modelId = GameUnitManager.hero.body;
         this.curShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.curShow.state = Action.STAND;
         this.curShow.job = GameUnitManager.hero.job;
         this.curShow.sex = GameUnitManager.hero.sex;
         this.curShow.wing = Data_lib.wing[this.leftLevel][Enum_job.getBaseJob(GameUnitManager.hero.job) * 2 + GameUnitManager.hero.sex + 6];
         this.curShow.setFrameInterval(150);
         this.curShow.updateLayer();
         this.nextShow = new Child_tianTiUnit();
         addChild(this.nextShow);
         this.nextShow.x = 393;
         this.nextShow.y = 280;
         this.nextShow.way = 3;
         this.nextShow.type = Child_tianTiUnit.PLAYER;
         this.nextShow.modelId = GameUnitManager.hero.body;
         this.nextShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.nextShow.state = Action.STAND;
         this.nextShow.job = GameUnitManager.hero.job;
         this.nextShow.sex = GameUnitManager.hero.sex;
         this.nextShow.wing = Data_lib.wing[this.rightLevel][Enum_job.getBaseJob(GameUnitManager.hero.job) * 2 + GameUnitManager.hero.sex + 6];
         this.nextShow.setFrameInterval(150);
         this.nextShow.updateLayer();
         ComponentUtil.getTextField("亲，您还没有翅膀哦！赶紧选择一个你喜欢的翅膀吧！",this,{
            "x":130,
            "y":48,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.buyBtn1 = ComponentUtil.getButton("免费购买","Button_TwoBule91",this,{
            "x":102,
            "y":334,
            "textColor":16771436
         },Global.Img_Cdm);
         this.buyBtn1.callBack = function():void
         {
            WingCGMessage.CG_WING_BUY(1);
            visible = false;
         };
         this.buyBtn2 = ComponentUtil.getButton("20元宝购买","Button_TwoBule91",this,{
            "x":337,
            "y":334,
            "textColor":16771436
         },Global.Img_Cdm);
         this.buyBtn2.callBack = function():void
         {
            if(GameUnitManager.hero.money < 20)
            {
               UIManager.centerBroadcast.addMsg("元宝不足");
            }
            else
            {
               visible = false;
               EffectManager.removeEffect(btn2Effect);
               WingCGMessage.CG_WING_BUY(2);
            }
         };
         this.btn2Effect = EffectManager.addEffect("35289",this.buyBtn2,1000,this.buyBtn2.width / 2,this.buyBtn2.height / 2,true);
         ComponentUtil.getTextField(Data_lib.wing[this.leftLevel][0] + "（" + Data_lib.wing[this.leftLevel][1] + "）",this,{
            "x":95,
            "y":294,
            "color":16755712,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(Data_lib.wing[this.rightLevel][0] + "（" + Data_lib.wing[this.rightLevel][1] + "）",this,{
            "x":329,
            "y":294,
            "color":16755712,
            "size":12,
            "leading":0
         });
         curAttribute = Data_lib.wing[this.leftLevel][8].split(",");
         currentAttributeArray = [];
         for(i in curAttribute)
         {
            currentAttributeArray[i] = [];
            currentAttributeArray[i] = curAttribute[i].split("_");
            for(id in currentAttributeArray[i])
            {
               currentAttributeArray[i][id] = Number(currentAttributeArray[i][id]);
            }
         }
         nextAttribute = Data_lib.wing[this.rightLevel][8].split(",");
         nextAttributeArray = [];
         for(j in nextAttribute)
         {
            nextAttributeArray[j] = [];
            nextAttributeArray[j] = nextAttribute[j].split("_");
            for(id2 in nextAttributeArray[j])
            {
               nextAttributeArray[j][id2] = Number(nextAttributeArray[j][id2]);
            }
         }
         totalString = "";
         for(k in currentAttributeArray)
         {
            increaseStr = currentAttributeArray[k][2] == 1 ? String(currentAttributeArray[k][1]) : String(int(currentAttributeArray[k][2] * 1000) / 10) + "%";
            totalString += Model_wing.attributeStringArray[k] + ":+" + increaseStr;
            if(k < currentAttributeArray.length - 1)
            {
               totalString += "\n";
            }
         }
         ComponentUtil.getTextField(totalString,this,{
            "x":54,
            "y":91,
            "color":16776960,
            "size":12,
            "leading":0
         });
         totalString = "";
         for(l in nextAttributeArray)
         {
            increaseStr = nextAttributeArray[l][2] == 1 ? String(nextAttributeArray[l][1]) : String(int(nextAttributeArray[l][2] * 1000) / 10) + "%";
            totalString += Model_wing.attributeStringArray[l] + ":+" + increaseStr;
            if(l < nextAttributeArray.length - 1)
            {
               totalString += "\n";
            }
         }
         ComponentUtil.getTextField(totalString,this,{
            "x":290,
            "y":91,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Prompt_TJZK",this,{
            "x":376,
            "y":84
         },Global.ChiBangdm);
         Global.control.registerCallBack(Enum_MsgType.ROLE_MODEL_CHANGE,this.changeModel);
      }
      
      private function changeModel() : void
      {
         this.curShow.modelId = GameUnitManager.hero.body;
         this.curShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.curShow.sex = GameUnitManager.hero.sex;
         this.curShow.updateLayer();
         this.nextShow.modelId = GameUnitManager.hero.body;
         this.nextShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.nextShow.sex = GameUnitManager.hero.sex;
         this.nextShow.updateLayer();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.curShow.onFrame);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.nextShow.onFrame);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.curShow.onFrame);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.nextShow.onFrame);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

