package com.yiTian.view.modules.fubenSel
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SaoDangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.WorldConfig;
   import com.yiTian.view.Panel;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class View_fuBenSaodanging extends Panel
   {
      
      private static var _type1:int;
      
      private static var _type2:int;
      
      public static var lefTimes:int;
      
      public static var isSaoDangIng:Boolean = false;
      
      public static var GAPWIDTH:int = 63;
      
      private static var selectTypeDic:Dictionary = new Dictionary();
      
      public static var isQingJiao:Boolean = false;
      
      private static var isShowBmp:Boolean = false;
      
      private var _item2:Item2;
      
      private var cleanContainer:ShaoDangContainer;
      
      private var monsterNameTxt:MyTextField;
      
      private var qingJiaoBtn:Button;
      
      public var monsterArr:Array;
      
      public var monsterLvlArr:Array;
      
      private var tishiTxt:MyTextField;
      
      private var shape:Shape;
      
      private var back:Sprite;
      
      private var SMS_CheckBox:CheckBox;
      
      private var tf_vec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var checkBoxVec:Vector.<CheckBox> = new Vector.<CheckBox>();
      
      private var checkPos:Array = [[395,280],[395,300],[458,300]];
      
      private var txtArr:Array = [" 自动使用体力药剂"," 绿装","蓝装"];
      
      private var _pointId:int;
      
      private var _fuBenId:int;
      
      private var currentTimes:int;
      
      private var lastTime:int;
      
      private var temArr:Array = [];
      
      public function View_fuBenSaodanging()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var tf:MyTextField = null;
         var ch:CheckBox = null;
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChildAt(this.shape,0);
         this.back = new Sprite();
         addChild(this.back);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":608,
            "height":330 + GAPWIDTH
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":24,
            "y":40,
            "width":560,
            "height":280 + GAPWIDTH
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.back,{
            "x":34,
            "y":50,
            "width":325,
            "height":260 + GAPWIDTH
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.back,{
            "x":395,
            "y":155,
            "width":180,
            "height":100
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60132",6),this.back,{
            "x":370,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60133",6),this.back,{
            "x":420,
            "y":260,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60134",6),this.back,{
            "x":370,
            "y":130,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("自动分解",this.back,{
            "x":510,
            "y":299,
            "color":11904647,
            "size":12,
            "leading":0
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":574,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.monsterNameTxt = ComponentUtil.getTextField("",this,{
            "x":396,
            "y":163,
            "leading":6
         });
         this.qingJiaoBtn = ComponentUtil.getButton(LangConfig.getWord("816",0),"Button_Orange",this,{
            "x":421 - 15,
            "y":281 + GAPWIDTH
         });
         this.qingJiaoBtn.callBack = this.funcHandle;
         this.tishiTxt = ComponentUtil.getTextField(LangConfig.getWord("817",0) + "\n" + LangConfig.getWord("818",0) + "\n" + LangConfig.getWord("819",0),this,{
            "x":35,
            "y":60
         });
         this.tishiTxt.leading = 3;
         this.tishiTxt.textColor = 16043313;
         this.cleanContainer = new ShaoDangContainer(325,246 + GAPWIDTH);
         this.cleanContainer.x = 33;
         this.cleanContainer.y = 60;
         addChild(this.cleanContainer);
         this.SMS_CheckBox = new CheckBox("","CheckBox01",Global.Img_Cdm);
         this.SMS_CheckBox.x = 395;
         this.SMS_CheckBox.y = 260 + GAPWIDTH;
         this.SMS_CheckBox.selected = true;
         addChild(this.SMS_CheckBox);
         this.SMS_CheckBox.clickFun = this.checkCliFun;
         selectTypeDic[this.SMS_CheckBox] = this.SMS_CheckBox.selected;
         i = 0;
         while(i < 3)
         {
            ch = new CheckBox(HtmlUtil.font(this.txtArr[i],"#ff7700"),"CheckBox01",Global.Img_Cdm);
            ch.x = this.checkPos[i][0];
            ch.y = this.checkPos[i][1];
            ch.selected = false;
            addChild(ch);
            this.checkBoxVec.push(ch);
            ch.clickFun = this.checkCliFun;
            selectTypeDic[ch] = ch.selected;
            i++;
         }
         this._item2 = Item2.getInstance();
         this._item2.x = 395;
         this._item2.y = 80;
         addChild(this._item2);
         var j:int = 0;
         while(j < 5)
         {
            tf = ComponentUtil.getTextField(LangConfig.getWord("820",0),this,{
               "x":403,
               "y":182.5 + j * 16.5,
               "realWidth":160,
               "color":11515029,
               "leading":3
            });
            tf.visible = false;
            this.tf_vec.push(tf);
            j++;
         }
      }
      
      private function checkCliFun(e:CheckBox) : void
      {
         if(isQingJiao)
         {
            e.selected = selectTypeDic[e];
            UIManager.centerBroadcast.addMsg("正在清剿中，请稍等");
            return;
         }
         selectTypeDic[e] = e.selected;
      }
      
      public function set pointId(_pId:int) : void
      {
         this._pointId = _pId;
      }
      
      public function get pointId() : int
      {
         return this._pointId;
      }
      
      public function set fubenId(_value:int) : void
      {
         this._fuBenId = _value;
      }
      
      public function get fubenId() : int
      {
         return this._fuBenId;
      }
      
      private function funcHandle(e:MouseEvent) : void
      {
         if(int(GameUnitManager.hero.vigor / 50) < 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("821",0));
            return;
         }
         if((e.target as Button).label == LangConfig.getWord("816",0))
         {
            if(this.SMS_CheckBox.selected)
            {
               if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() == 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("38",0));
                  return;
               }
            }
            lefTimes = this._item2.getTimes();
            this.tishiTxt.visible = false;
            SaoDangCGMessage.CG_CONFIRM_CLEAN(lefTimes,Global.sceneID,this.fubenId,this.checkBoxVec[0].selected,this.checkBoxVec[1].selected,this.checkBoxVec[2].selected,this.SMS_CheckBox.selected);
            this._item2.update(2);
         }
         else if(this.qingJiaoBtn.label == LangConfig.getWord("674",0))
         {
            this.setBtnLabel(LangConfig.getWord("816",0));
            this.currentTimes = 0;
            this.cleanContainer.cancleSaoDang = true;
            this.removeFrame();
            this._item2.update(1);
            SaoDangCGMessage.CG_SAODAN_STOP();
         }
      }
      
      public function setBtnLabel(str:String) : void
      {
         this.qingJiaoBtn.label = str;
      }
      
      public function dispose() : void
      {
         this.cleanContainer.dispose();
         this.cleanContainer.reset();
      }
      
      public function dataFrameHandle() : void
      {
         this.lastTime = getTimer();
         this.getFrame();
         this._item2.updataTimes(lefTimes);
         this.cleanContainer.curSDCount = 1;
      }
      
      public function bagFullHandle() : void
      {
         if(this.SMS_CheckBox.selected)
         {
            this.removeFrame();
            this.cleanContainer.isFinished = true;
            this.setBtnLabel(LangConfig.getWord("816",0));
            this._item2.update(1);
            isQingJiao = false;
            this.currentTimes = 0;
         }
      }
      
      public function updata(currenNum:int, lefeNum:int, exp:int, meridian:int, bindSilver:int, temArr:Array) : void
      {
         this.cleanContainer.addItem([currenNum,exp,meridian,bindSilver,temArr],lefeNum >= 1);
         this.currentTimes = currenNum;
         this.cleanContainer.curSDCount = currenNum + 1;
         this._item2.updataTimes(lefeNum);
      }
      
      public function stopSaoDang() : void
      {
         this.removeFrame();
         this.cleanContainer.isFinished = true;
         this.setBtnLabel(LangConfig.getWord("816",0));
         this._item2.update(1);
         isQingJiao = false;
         this.currentTimes = 0;
      }
      
      public function getFrame() : void
      {
         if(!isQingJiao)
         {
            return;
         }
         GameScene.instance.addFrameCallBack(this.frameHandle);
      }
      
      public function removeFrame() : void
      {
         isQingJiao = false;
         GameScene.instance.removeFrameCallBack(this.frameHandle);
      }
      
      private function getLevel(value:Array) : int
      {
         return value[1];
      }
      
      private function getMonster() : void
      {
         var j:int = 0;
         var tem_str:String = null;
         var temStr:String = HtmlUtil.bold(HtmlUtil.font(WorldConfig.getMapName(this.fubenId),"#3399cc",14));
         var len:int = 0;
         var i:int = 0;
         while(i < this.monsterArr.length)
         {
            len = int(this.monsterArr[i][2]);
            j = 0;
            while(j < len)
            {
               tem_str = this.getStr(i);
               this.tf_vec[j].visible = true;
               if(j >= 4)
               {
                  this.tf_vec[j].visible = false;
               }
               this.tf_vec[j].text = tem_str;
               j++;
            }
            i++;
         }
         this.monsterNameTxt.textColor = 14013822;
         this.monsterNameTxt.htmlText = temStr;
      }
      
      private function getStr(_index:int) : String
      {
         var temStr:String = null;
         var tem_str:String = null;
         var i:int = 0;
         while(i < this.monsterLvlArr.length)
         {
            if((this.monsterLvlArr[0].split("_") as Array)[0] == 1)
            {
               if(i < this.monsterArr.length)
               {
                  tem_str = this.getspaceStr(8);
                  temStr = this.monsterArr[_index][1] + tem_str + "Lv" + String((this.monsterLvlArr[0].split("_") as Array)[1]);
               }
            }
            i++;
         }
         return temStr;
      }
      
      private function getspaceStr(_num:int) : String
      {
         if(!_num)
         {
            return null;
         }
         var temStr:String = "";
         var i:int = 0;
         while(i < _num)
         {
            temStr += "  ";
            i++;
         }
         return temStr;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this._item2.update(1);
            this.get_level();
            this.getMonster();
            this.tishiTxt.visible = true;
            if(!isShowBmp)
            {
               isShowBmp = true;
               if(!Global.Map_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Map_Imgs.swf",function(info:Object):void
                  {
                     Global.Map_Imgsdm = info.applicationDomain;
                     addBmp();
                  });
               }
               else
               {
                  this.addBmp();
               }
            }
         }
         else
         {
            this.removeFrame();
            this.reset();
         }
      }
      
      private function addBmp() : void
      {
         ComponentUtil.getBitmap("Title_Clean",this.back,{
            "x":224,
            "y":5
         },Global.Map_Imgsdm);
      }
      
      private function reset() : void
      {
         this.setBtnLabel(LangConfig.getWord("816",0));
         this.currentTimes = 0;
         View_fuBenSaodanging.isQingJiao = false;
         this.cleanContainer.dispose();
         this.cleanContainer.reset();
      }
      
      private function frameHandle(instance:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime >= 800)
         {
            SaoDangCGMessage.CG_CURRENT_CLEAN_TIMES(this.currentTimes + 1);
            this.setBtn(false);
            GameScene.instance.removeFrameCallBack(this.frameHandle);
            this.lastTime = now;
         }
      }
      
      public function setBtn(value:Boolean) : void
      {
         this.qingJiaoBtn.enabled = value;
         this.qingJiaoBtn.buttonMode = value;
      }
      
      public function get_level() : void
      {
         var i:int = 0;
         while(i < this.monsterLvlArr.length)
         {
            this.temArr.push(this.getLevel(this.monsterLvlArr[i].split("_")));
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         var temX:int = 0;
         var temY:int = 0;
         var i:int = 0;
         var ch:CheckBox = null;
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         this.back.x = (Global.stage.stageWidth - this.back.width) / 2;
         this.back.y = (Global.stage.stageHeight - this.back.height) / 2;
         temX = (Global.stage.stageWidth - this.back.width) / 2;
         temY = (Global.stage.stageHeight - this.back.height) / 2;
         CloseButton.x = temX + 574;
         CloseButton.y = temY + 5;
         this.monsterNameTxt.x = 420 + temX;
         this.monsterNameTxt.y = 160 + temY;
         this.qingJiaoBtn.x = 440 + temX - 15;
         this.qingJiaoBtn.y = 283 + temY + 60;
         this.tishiTxt.x = temX + 35;
         this.tishiTxt.y = temY + 60;
         this.cleanContainer.x = temX + 33;
         this.cleanContainer.y = temY + 60;
         this._item2.x = temX + 395;
         this._item2.y = temY + 60;
         this.SMS_CheckBox.x = 395 + temX;
         this.SMS_CheckBox.y = 260 + temY;
         i = 0;
         while(i < 5)
         {
            this.tf_vec[i].x = 403 + temX;
            this.tf_vec[i].y = 182.5 + i * 16.5 + temY;
            i++;
         }
         var j:int = 0;
         while(j < 3)
         {
            ch = this.checkBoxVec[j];
            ch.x = this.checkPos[j][0] + temX;
            ch.y = this.checkPos[j][1] + temY;
            j++;
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.RadioButton;
import com.ui.controls.RadioButtonGroup;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.utils.HtmlUtil;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;

class Item2 extends Sprite
{
   
   private static var pool:Array = [];
   
   public static var type:int = 1;
   
   private static var type_str:String = "All";
   
   private var rbg:RadioButtonGroup;
   
   private var rb_yl:RadioButton;
   
   private var rb_yb:RadioButton;
   
   private var left_txt:MyTextField;
   
   private var ConsuTiliTxt:MyTextField;
   
   private var ConsuTimesTxt:MyTextField;
   
   private var dynamic1Txt:MyTextField;
   
   private var dynamic2Txt:MyTextField;
   
   private var _type:int;
   
   private var back1:ScaleBitmap;
   
   private var MAX:int;
   
   private var shuaTimes:int = 1;
   
   public function Item2()
   {
      super();
      this.back1 = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":62.95,
         "y":46.8,
         "width":27.4,
         "height":19
      },Global.Img_Cdm);
      this.ConsuTiliTxt = ComponentUtil.getTextField(LangConfig.getWord("822",0),this,{
         "x":35,
         "y":23,
         "textColor":14013822
      });
      this.ConsuTimesTxt = ComponentUtil.getTextField(LangConfig.getWord("823",0),this,{
         "x":36,
         "y":48,
         "textColor":14013822
      });
      this.dynamic1Txt = ComponentUtil.getTextField("1",this,{
         "x":65,
         "y":48,
         "realWidth":23,
         "realHeight":18,
         "type":TextFieldType.DYNAMIC,
         "restrict":"0-9",
         "maxChars":2,
         "color":16184781
      });
      this.dynamic2Txt = ComponentUtil.getTextField("50",this,{
         "x":138,
         "y":48,
         "realHeight":18,
         "color":16184781
      });
      this.dynamic2Txt.visible = false;
      this.dynamic1Txt.align = TextFormatAlign.CENTER;
      this.dynamic1Txt.addEventListener(Event.CHANGE,this.changedHandle);
      this.left_txt = ComponentUtil.getTextField("",this,{
         "x":41,
         "y":34,
         "size":24,
         "textColor":14013822
      });
      this.left_txt.visible = false;
      this.rbg = new RadioButtonGroup();
      this.rbg.direction = RadioButtonGroup.VERTICAL;
      this.rbg.space = 30;
      this.rbg.x = 15;
      this.rbg.y = 23;
      addChild(this.rbg);
      this.back1.visible = true;
      this.rb_yl = ComponentUtil.getRadioButton("","CheckBox01",this.rbg,{"value":"All"},Global.Img_Cdm);
      this.rb_yb = ComponentUtil.getRadioButton("","CheckBox01",this.rbg,{"value":"times"},Global.Img_Cdm);
      this.rbg.selectedItem = this.rb_yl;
      this.rbg.addEventListener(RadioButtonGroup.SELECTED_CHANGE,function():void
      {
         var value:Object = null;
         if(Boolean(rbg.selectedItem))
         {
            value = rbg.selectedItem.value;
            handleOfType(value as String);
            type_str = String(value);
         }
      });
   }
   
   public static function getInstance() : Item2
   {
      if(Boolean(pool.length))
      {
         return pool.pop();
      }
      return new Item2();
   }
   
   public function update(type:int) : void
   {
      this._type = type;
      if(type == 1)
      {
         this.addRadioButton();
      }
      else if(type == 2)
      {
         this.addTxt();
      }
   }
   
   private function addTxt() : void
   {
   }
   
   private function addRadioButton() : void
   {
      this.getCheckTxt(true);
      this.dynamic1Txt.text = "1";
      this.dynamic1Txt.dispatchEvent(new Event(Event.CHANGE));
      this.left_txt.visible = false;
   }
   
   public function updataTimes(_timesNum:int) : void
   {
      this.left_txt.visible = true;
      this.getCheckTxt(false);
      this.left_txt.htmlText = LangConfig.getWord("824",0) + HtmlUtil.font(String(_timesNum),"#f9ff00",24) + LangConfig.getWord("825",0);
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(!value)
      {
         this.rbg.selectedItem = this.rb_yl;
         this.handleOfType("All");
         pool.push(this);
      }
   }
   
   public function getTimes() : int
   {
      if(type_str == "All")
      {
         return int(GameUnitManager.hero.vigor / 50);
      }
      return int(this.dynamic1Txt.text);
   }
   
   private function handleOfType(typeStr:String) : void
   {
      if(typeStr == "All")
      {
         this.allHanlde();
      }
      else
      {
         if(typeStr != "times")
         {
            throw new Error("类型错误");
         }
         this.timesHandle();
      }
   }
   
   private function allHanlde() : void
   {
      this.dynamic1Txt.type = TextFieldType.DYNAMIC;
   }
   
   private function timesHandle() : void
   {
      this.dynamic1Txt.type = TextFieldType.INPUT;
   }
   
   private function getCheckTxt(value:Boolean) : void
   {
      this.ConsuTiliTxt.visible = value;
      this.ConsuTimesTxt.visible = value;
      this.dynamic1Txt.visible = value;
      this.back1.visible = value;
      this.rbg.visible = value;
   }
   
   private function changedHandle(e:Event) : void
   {
      this.MAX = int(GameUnitManager.hero.vigor / 50);
      var tf:MyTextField = e.target as MyTextField;
      if(int(tf.text) < 1)
      {
         tf.text = "1";
      }
      else if(int(tf.text) > this.MAX)
      {
         tf.text = String(this.MAX);
      }
      var temNum:int = int(tf.text);
      this.shuaTimes = temNum;
      this.ConsuTimesTxt.htmlText = LangConfig.getWord("826",0) + HtmlUtil.font(String(50 * temNum),"#f9ff00") + LangConfig.getWord("827",0);
   }
}
