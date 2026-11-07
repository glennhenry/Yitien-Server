package com.yiTian.view.modules.farm
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_farm_farmer;
   import com.yiTian.data.vo.Vo_farm_fruit;
   import com.yiTian.data.vo.Vo_farm_land;
   import com.yiTian.data.vo.Vo_farm_land_expand;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.FarmGuideManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FarmHandler;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.friends.Model_Friends;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_farm_land extends Sprite
   {
      
      private static const effect_quality_list:Vector.<String> = new <String>["","35148","35149","35150","35151"];
      
      private static const num_chinese:Vector.<String> = new <String>[LangConfig.getWord("8",9),LangConfig.getWord("9",9),LangConfig.getWord("10",9),LangConfig.getWord("11",9),LangConfig.getWord("12",9),LangConfig.getWord("13",9),LangConfig.getWord("14",9),LangConfig.getWord("15",9),LangConfig.getWord("16",9),LangConfig.getWord("17",9),LangConfig.getWord("18",9),LangConfig.getWord("19",9)];
      
      private var _bg:Bitmap;
      
      private var _type:uint;
      
      private var _expand:Bitmap;
      
      private var _fruit:Bitmap;
      
      private var _effectMature:Effect;
      
      private var _effectQuality:Effect;
      
      private var _fruitTime:MyTextField;
      
      private var _fruitOutput:MyTextField;
      
      private var _toolTip:View_farm_small_tool;
      
      private var _hotArea:Sprite;
      
      private var _index:uint;
      
      private var _vo:Vo_farm_land;
      
      private var _refreshBtn:View_farm_small_icon;
      
      private var expandTip:Boolean;
      
      public function View_farm_land()
      {
         super();
         this.init();
      }
      
      public function get vo() : Vo_farm_land
      {
         return this._vo;
      }
      
      public function set vo(value:Vo_farm_land) : void
      {
         this._vo = value;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(value:uint) : void
      {
         this._index = value;
      }
      
      public function get hotArea() : Sprite
      {
         return this._hotArea;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this.addChild(this._bg);
         this._fruitTime = ComponentUtil.getTextField("",this,{
            "x":25,
            "y":-70,
            "color":14662240,
            "size":12,
            "leading":5
         });
         this._fruitOutput = ComponentUtil.getTextField("",this,{
            "x":25,
            "y":-56,
            "color":14662240,
            "size":12,
            "leading":5
         });
         this._fruitTime.mouseEnabled = false;
         this._fruitOutput.mouseEnabled = false;
         this._fruitTime.visible = false;
         this._fruitOutput.visible = false;
         this._fruit = new Bitmap();
         this.addChild(this._fruit);
         this._fruit.x = 70 - 45;
         this._fruit.y = 40 - 76;
         this.drawHotArea();
         this.mouseEnabled = false;
      }
      
      private function updateFruitOutput() : void
      {
         var str:String = Data_lib.farm_fruit[this.vo.fruit_id][Vo_farm_fruit.name] + "（" + this.vo.output_left + "/" + this.vo.output_max + "）";
         var str1:String = this.getAddString();
         if(Boolean(str1) && Boolean(str1.length))
         {
            str1 = " +" + str1;
         }
         this._fruitOutput.htmlText = HtmlUtil.font(str,Model_farm.fruitColor1[Data_lib.farm_fruit[this.vo.fruit_id][Vo_farm_fruit.fruitCharacter] - 1]) + HtmlUtil.font(str1,"#00ff00");
      }
      
      public function updateMatureTime() : void
      {
         if(!this.vo)
         {
            return;
         }
         if(this.vo.status == Vo_farm_land.land_status_have_fruit || this.vo.status == Vo_farm_land.land_status_need_water)
         {
            this._fruitTime.text = LangConfig.getWord("20",9) + DateUtil.getHMSBySecond2(this.vo.time_left,"::");
         }
         else if(this.vo.status == Vo_farm_land.land_status_mature)
         {
            this._fruitTime.text = LangConfig.getWord("21",9);
         }
      }
      
      public function update(vo:Vo_farm_land, id:Number = 0) : void
      {
         if(buttonMode)
         {
            this.buttonMode = false;
         }
         this.vo = vo;
         this.checkMouseStatus();
         this.addEffectQuality();
         var list:Vector.<Vo_farm_land> = Model_farm.isMine(id) ? Model_farm.instace.landList_mine : Model_farm.instace.landList_other;
         if(!vo)
         {
            if(id != 0 && this._index == list.length)
            {
               this.type = Model_farm.land_type_expand;
               if(Model_farm.isMine(Model_farm.currentFarmId))
               {
                  this.buttonMode = true;
               }
            }
            else
            {
               this.type = Model_farm.land_type_close;
            }
            this._fruitTime.visible = false;
            this._fruitOutput.visible = false;
            if(Boolean(this._fruit))
            {
               this._fruit.visible = false;
               this._fruit.bitmapData = null;
            }
            if(Boolean(this._toolTip))
            {
               this._toolTip.type = 0;
            }
            if(Boolean(this._effectMature))
            {
               EffectManager.removeEffect(this._effectMature);
               this._effectMature = null;
            }
         }
         else
         {
            if(this.type != Model_farm.land_type_open)
            {
               this.type = Model_farm.land_type_open;
            }
            if(vo.fruit_id > 0)
            {
               this.updateMatureTime();
               this._fruitTime.textColor = Model_farm.fruitColor2[Data_lib.farm_fruit[vo.fruit_id][Vo_farm_fruit.fruitCharacter] - 1];
               this.updateFruitOutput();
               this.checkFruitStatus();
               if(vo.status != Vo_farm_land.land_status_have_fruit)
               {
                  this.hideBtn();
               }
               this.loadFruit();
            }
            else
            {
               this.clearFruit();
               this._fruitTime.visible = false;
               this._fruitOutput.visible = false;
               if(Boolean(this._effectMature))
               {
                  EffectManager.removeEffect(this._effectMature);
                  this._effectMature = null;
               }
            }
         }
         this.checkTips();
      }
      
      private function getAddString() : String
      {
         var vo:Vo_farm_farmer = null;
         var farmerIndex:uint = (this.vo.position - 1) / 3 + 1;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            if(Boolean(Model_farm.instace.farmerList_mine))
            {
               vo = Model_farm.instace.farmerList_mine[farmerIndex];
               if(Boolean(vo) && Boolean(vo.id))
               {
                  return this.getAddCount(vo.level).toString();
               }
            }
         }
         else if(Boolean(Model_farm.instace.farmerList_other))
         {
            vo = Model_farm.instace.farmerList_other[farmerIndex];
            if(Boolean(vo) && Boolean(vo.id))
            {
               return this.getAddCount(vo.level).toString();
            }
         }
         return "";
      }
      
      private function getAddCount(farmerLevel:uint) : uint
      {
         var fvo:Vo_unit = null;
         var level:uint = 0;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            level = uint(GameUnitManager.hero.level);
         }
         else
         {
            fvo = Model_Friends.getFriendVoById(Model_farm.currentFarmId);
            level = uint(fvo.level);
         }
         if(level == 0)
         {
            return 0;
         }
         var value:int = farmerLevel - level;
         var op:uint = uint(Data_lib.farm_fruit[this.vo.fruit_id][Vo_farm_fruit.originalProduction]);
         if(value < -5)
         {
            return Math.ceil(op * 0.25);
         }
         if(value >= -5 && value <= 5)
         {
            return Math.ceil(op * 0.5);
         }
         if(value > 5)
         {
            return Math.ceil(op * 0.75);
         }
         return 0;
      }
      
      private function checkTips() : void
      {
         var moneyType:String = null;
         var moneyValue:uint = 0;
         var str:String = null;
         var str1:String = null;
         var str2:String = null;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            if(this.type == Model_farm.land_type_open)
            {
               if(this.vo.fruit_id == 0)
               {
                  TipManager.bind(this,LangConfig.getWord("165",9));
               }
               else
               {
                  TipManager.unBind(this);
                  TipManager.hide();
               }
            }
            else if(this.type == Model_farm.land_type_expand)
            {
               moneyType = Data_lib.attribute[Data_lib.farm_land_expand[this.index + 1][Vo_farm_land_expand.moneyType]][0];
               moneyValue = uint(Data_lib.farm_land_expand[this.index + 1][Vo_farm_land_expand.moneyValue]);
               str = HtmlUtil.font(LangConfig.getWord("28",9) + "\n",ColorConstant.getColorStr(4));
               str1 = HtmlUtil.font(LangConfig.getWord("30",9) + Data_lib.farm_land_expand[this.index + 1][Vo_farm_land_expand.levelNeed] + LangConfig.getWord("31",9) + "\n","#fefefe");
               str2 = HtmlUtil.font(LangConfig.getWord("32",9) + moneyValue + moneyType,"#fefefe");
               TipManager.bind(this,str + str1 + str2);
            }
            else
            {
               TipManager.unBind(this);
            }
         }
         else
         {
            TipManager.unBind(this);
         }
      }
      
      private function checkMouseStatus() : void
      {
         if(Model_farm.instace.positionOfOverLand == 0)
         {
            return;
         }
         if(Boolean(this.vo))
         {
            if(this.vo.status == Vo_farm_land.land_status_need_water)
            {
               Model_farm.instace.mouseType = Model_farm.mouse_type_water_tool;
            }
            else if(this.vo.status == Vo_farm_land.land_status_mature)
            {
               if(this.vo.isMine || this.vo.canSteal)
               {
                  Model_farm.instace.mouseType = Model_farm.mouse_type_pick_tool;
               }
               else
               {
                  Model_farm.instace.mouseType = Model_farm.mouse_type_none;
               }
            }
            else if(Model_farm.instace.positionOfOverLand == this._index + 1 && Model_farm.instace.mouseType != Model_farm.mouse_type_seed)
            {
               Model_farm.instace.mouseType = Model_farm.mouse_type_none;
            }
         }
         else if(Model_farm.instace.mouseType != Model_farm.mouse_type_seed)
         {
            Model_farm.instace.mouseType = Model_farm.mouse_type_none;
         }
      }
      
      private function checkFruitStatus() : void
      {
         if(this.vo.status == Vo_farm_land.land_status_need_water)
         {
            if(this._toolTip == null)
            {
               this._toolTip = new View_farm_small_tool();
               this.addChild(this._toolTip);
               this._toolTip.x = 90;
               this._toolTip.y = -48;
            }
            this._toolTip.type = View_farm_small_tool.type_need_water;
         }
         else if(this.vo.status == Vo_farm_land.land_status_mature)
         {
            if(this.vo.isMine || this.vo.canSteal)
            {
               if(this._toolTip == null)
               {
                  this._toolTip = new View_farm_small_tool();
                  this.addChild(this._toolTip);
                  this._toolTip.x = 90;
                  this._toolTip.y = -48;
               }
               this._toolTip.type = View_farm_small_tool.type_can_pick;
               if(!this._effectMature)
               {
                  this._effectMature = EffectManager.addEffect("35168",this._hotArea,800,70,5,true);
               }
            }
            else if(Boolean(this._toolTip))
            {
               this._toolTip.type = 0;
            }
         }
         else if(Boolean(this._toolTip))
         {
            this._toolTip.type = 0;
         }
      }
      
      private function loadFruit() : void
      {
         this._fruit.visible = true;
         if(Boolean(this._fruit.bitmapData))
         {
            return;
         }
         var pic:uint = uint(Data_lib.npc[this.vo.fruit_id][Npc.BODY]);
         var path:String = "resource/image/farm/" + pic + ".png";
         Utils.getLoadBitmap(path,this._fruit);
      }
      
      private function addEffectQuality() : void
      {
         var swf:String = null;
         if(Boolean(this._effectQuality))
         {
            EffectManager.removeEffect(this._effectQuality);
            this._effectQuality = null;
         }
         if(Boolean(this.vo) && Boolean(this.vo.fruit_id))
         {
            swf = View_farm_land.effect_quality_list[Data_lib.farm_fruit[this.vo.fruit_id][Vo_farm_fruit.fruitCharacter] - 1];
            if(Boolean(swf) && swf != "")
            {
               this._effectQuality = EffectManager.addEffect(swf,this._hotArea,900,70,0,true);
            }
         }
      }
      
      private function clearFruit() : void
      {
         if(Boolean(this._fruit.bitmapData))
         {
            this._fruit.visible = false;
            this._fruit.bitmapData = null;
         }
         if(Boolean(this._toolTip))
         {
            this._toolTip.type = 0;
         }
      }
      
      private function drawHotArea() : void
      {
         this._hotArea = new Sprite();
         this._hotArea.name = Model_farm.farm_land_hot_area;
         this.addChild(this._hotArea);
         this._hotArea.graphics.beginFill(153,0);
         this._hotArea.graphics.lineStyle(1,1114112,0);
         this._hotArea.graphics.moveTo(0,42);
         this._hotArea.graphics.lineTo(71,7);
         this._hotArea.graphics.lineTo(138,41);
         this._hotArea.graphics.lineTo(70,79);
         this._hotArea.graphics.lineTo(0,42);
         this._hotArea.graphics.endFill();
         this._hotArea.graphics.beginFill(153,0);
         this._hotArea.graphics.moveTo(71 - 30,7 - 20);
         this._hotArea.graphics.lineTo(71 - 30 + 60,7 - 20);
         this._hotArea.graphics.lineTo(71 - 30 + 60,7 - 20 + 30);
         this._hotArea.graphics.lineTo(71 - 30,7 - 20 + 30);
         this._hotArea.graphics.lineTo(71 - 30,7 - 20);
         this._hotArea.graphics.endFill();
         this._hotArea.cacheAsBitmap = true;
         this._hotArea.addEventListener(MouseEvent.CLICK,this.onClickLand);
         this._hotArea.addEventListener(MouseEvent.MOUSE_OVER,this.onOverLand);
         this._hotArea.addEventListener(MouseEvent.MOUSE_OUT,this.onOutLand);
         this._hotArea.addEventListener(MouseEvent.MOUSE_DOWN,this.onDownLand);
         this._hotArea.addEventListener(MouseEvent.MOUSE_UP,this.onUpLand);
      }
      
      private function onClickLand(evt:MouseEvent) : void
      {
         var type:uint = 0;
         var count:uint = 0;
         var str:String = null;
         var str1:String = null;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            if(Boolean(this.vo))
            {
               if(Model_farm.instace.mouseType == Model_farm.mouse_type_none)
               {
                  if(this.type == Model_farm.land_type_open)
                  {
                     if(this.vo.fruit_id > 0)
                     {
                        Model_farm.instace.positionOfClickMyLand = this.index + 1;
                     }
                  }
               }
               else if(Model_farm.instace.mouseType == Model_farm.mouse_type_seed)
               {
                  if(this.vo.fruit_id > 0)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("25",9));
                  }
                  else
                  {
                     FarmCGMessage.cg_farm_plant(this.vo.position,Model_farm.instace.seedIdOnMouse);
                     FarmGuideManager.instance.nextStep(7);
                  }
               }
               else if(Model_farm.instace.mouseType != Model_farm.mouse_type_water_tool)
               {
                  if(Model_farm.instace.mouseType == Model_farm.mouse_type_pick_tool)
                  {
                  }
               }
            }
            else if(Model_farm.instace.mouseType == Model_farm.mouse_type_none)
            {
               if(this.type == Model_farm.land_type_expand)
               {
                  if(Model_farm.instace.masterBasic_mine.farmLevel < uint(Data_lib.farm_land_expand[this.index + 1][Vo_farm_land_expand.levelNeed]))
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("26",9));
                  }
                  else
                  {
                     type = uint(Data_lib.farm_land_expand[this.index + 1][Vo_farm_land_expand.moneyType]);
                     count = uint(Data_lib.farm_land_expand[this.index + 1][Vo_farm_land_expand.moneyValue]);
                     str = "";
                     str1 = Data_lib.attribute[type][0];
                     str = LangConfig.getWord("27",9,count,str1);
                     if(this.index <= 9)
                     {
                        str += LangConfig.getWord("214",9);
                     }
                     View_Alert.show(str,View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
                     {
                        FarmCGMessage.cg_farm_land_expand(GameUnitManager.hero.id,index + 1);
                     });
                  }
               }
            }
            else if(Model_farm.instace.mouseType == Model_farm.mouse_type_seed)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29",9));
            }
         }
         else
         {
            if(!this.vo)
            {
               return;
            }
            if(Model_farm.instace.mouseType == Model_farm.mouse_type_pick_tool)
            {
               FarmCGMessage.cg_farm_steal_fruit(this.vo.roleid,this.vo.position);
            }
            else if(Model_farm.instace.mouseType == Model_farm.mouse_type_water_tool)
            {
               FarmCGMessage.cg_farm_water(this.vo.roleid,this.vo.position);
            }
         }
      }
      
      private function onOverLand(evt:MouseEvent) : void
      {
         var canRefresh:uint = 0;
         Model_farm.instace.positionOfOverLand = this.index + 1;
         filters = Util.glowFFFF00;
         this.checkMouseStatus();
         if(Boolean(this.vo) && Boolean(this.vo.fruit_id))
         {
            this._fruitTime.visible = true;
            this._fruitOutput.visible = true;
            this.updateFruitOutput();
            if(Model_farm.isMine(Model_farm.currentFarmId))
            {
               canRefresh = uint(Data_lib.farm_fruit[this.vo.fruit_id][Vo_farm_fruit.ifRefresh]);
               if(canRefresh == 1 && Model_farm.instace.mouseType == Model_farm.mouse_type_none && this.vo.status != Vo_farm_land.land_status_mature)
               {
                  this.showBtn();
               }
            }
         }
      }
      
      private function onOutLand(evt:MouseEvent) : void
      {
         Model_farm.instace.positionOfOverLand = 0;
         filters = null;
         if(Model_farm.instace.mouseType == Model_farm.mouse_type_water_tool || Model_farm.instace.mouseType == Model_farm.mouse_type_pick_tool)
         {
            Model_farm.instace.mouseType = Model_farm.mouse_type_none;
         }
         if(this._fruitTime.visible || this._fruitOutput.visible)
         {
            this._fruitTime.visible = false;
            this._fruitOutput.visible = false;
         }
         this.hideBtn();
      }
      
      private function onDownLand(evt:MouseEvent) : void
      {
         if(Model_farm.instace.positionOfOverLand > 0)
         {
            if(Model_farm.instace.mouseType == Model_farm.mouse_type_water_tool)
            {
               if(Boolean(FarmHandler.waterToolMouse))
               {
                  FarmHandler.waterToolMouse.play();
               }
            }
            else if(Model_farm.instace.mouseType == Model_farm.mouse_type_pick_tool)
            {
               if(Boolean(FarmHandler.pickToolMouse))
               {
                  FarmHandler.pickToolMouse.play();
               }
            }
         }
      }
      
      private function onUpLand(evt:MouseEvent) : void
      {
         var pro:uint = 0;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            if(Boolean(this.vo))
            {
               if(Model_farm.instace.mouseType == Model_farm.mouse_type_water_tool)
               {
                  if(Boolean(FarmHandler.waterToolMouse))
                  {
                     FarmHandler.waterToolMouse.stop();
                  }
                  FarmCGMessage.cg_farm_water(Model_farm.currentFarmId,this.vo.position);
               }
               else if(Model_farm.instace.mouseType == Model_farm.mouse_type_pick_tool)
               {
                  FarmHandler.pickToolMouse.stop();
                  if(Model_farm.isMine(Model_farm.currentFarmId))
                  {
                     FarmCGMessage.cg_farm_pick_fruit(Model_farm.currentFarmId,this.vo.position);
                  }
                  else
                  {
                     FarmCGMessage.cg_farm_steal_fruit(Model_farm.currentFarmId,this.vo.position);
                  }
               }
            }
         }
         else
         {
            if(Boolean(this.vo) && Boolean(this.vo.fruit_id) && this.vo.status != Vo_farm_land.land_status_mature)
            {
               if(Model_farm.instace.mouseType == Model_farm.mouse_type_none)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("33",9));
               }
            }
            if(Boolean(this.vo) && Boolean(this.vo.fruit_id) && this.vo.status == Vo_farm_land.land_status_mature)
            {
               pro = uint(Data_lib.farm_fruit[this.vo.fruit_id][Vo_farm_fruit.protectOutput]);
               if(this.vo.output_left <= pro)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("34",9));
               }
            }
         }
      }
      
      public function addEffect(effect:String, totalTime:uint = 500, px:Number = 0, py:Number = 0) : void
      {
         EffectManager.addEffect(effect,this,totalTime,px,py,false);
      }
      
      private function onClickRefreshFruit(evt:MouseEvent) : void
      {
         this.hideBtn();
         if(Data_lib.farm_fruit[this.vo.fruit_id][Vo_farm_fruit.ifRefresh] == 1)
         {
            FarmHandler.openRefreshFruit(this.vo.position,this.vo.fruit_id);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("172",9));
         }
      }
      
      private function onClickKillFruit(evt:MouseEvent) : void
      {
         var str:String;
         this.hideBtn();
         str = HtmlUtil.font(LangConfig.getWord("35",9),"#fefefe") + HtmlUtil.font(LangConfig.getWord("36",9),"#ff0000") + HtmlUtil.font(LangConfig.getWord("37",9),"#fefefe");
         View_Alert.show(str,View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
         {
            FarmCGMessage.cg_farm_fruit_kill(GameUnitManager.hero.id,vo.position);
         });
      }
      
      public function hideBtn() : void
      {
         if(Boolean(this._refreshBtn) && this._refreshBtn.visible)
         {
            this._refreshBtn.visible = false;
         }
      }
      
      public function showBtn() : void
      {
         if(!this._refreshBtn)
         {
            this._refreshBtn = new View_farm_small_icon(View_farm_small_icon.type_refresh);
            this.hotArea.addChild(this._refreshBtn);
            this._refreshBtn.x = 14 + 40;
            this._refreshBtn.y = -15 - 10 - 10;
            this._refreshBtn.addEventListener(MouseEvent.CLICK,this.onClickRefreshFruit);
            TipManager.bind(this._refreshBtn,View_farm_small_icon.typeList[View_farm_small_icon.type_refresh]);
         }
         this._refreshBtn.visible = true;
         this.hotArea.setChildIndex(this._refreshBtn,this.hotArea.numChildren - 1);
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function set type(value:uint) : void
      {
         this._type = value;
         this.setStatus();
      }
      
      public function updateToolTip() : void
      {
         if(Boolean(this._toolTip))
         {
            this._toolTip.updatePosition();
         }
      }
      
      private function setStatus() : void
      {
         if(this._type == Model_farm.land_type_close)
         {
            this._bg.bitmapData = ComponentUtil.getBitmapData("Land",Global.ShanZhuang_Imgsdm);
            if(Boolean(this._expand))
            {
               this._expand.bitmapData = null;
            }
            this._bg.alpha = 1;
         }
         else if(this._type == Model_farm.land_type_open)
         {
            this._bg.bitmapData = ComponentUtil.getBitmapData("land_open",Global.ShanZhuang_Imgsdm);
            if(Boolean(this._expand))
            {
               this._expand.bitmapData = null;
            }
         }
         else if(this._type == Model_farm.land_type_expand)
         {
            this._bg.bitmapData = ComponentUtil.getBitmapData("Land",Global.ShanZhuang_Imgsdm);
            if(!this._expand)
            {
               this._expand = new Bitmap();
               this.addChild(this._expand);
               this._expand.x = 25;
               this._expand.y = -55;
            }
            this._expand.bitmapData = ComponentUtil.getBitmapData("expand",Global.ShanZhuang_Imgsdm);
         }
      }
   }
}

