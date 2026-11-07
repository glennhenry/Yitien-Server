package com.yiTian.view.modules.banhui.shenshou
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShenshouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import flash.utils.getTimer;
   
   public class ShenShouPaiHang extends Panel
   {
      
      public static var vecShenShouName:Vector.<String>;
      
      public static var shenShouNpc:Npc;
      
      public static var vecShenShouSize:Vector.<Number> = new <Number>[0.6,1,1.2];
      
      public static var shenShouMap:int = 12408;
      
      private static var shenShouNPCStar:int = 56981;
      
      private static var shenShouNPCEnd:int = 57061;
      
      public static var test1:int = 50000;
      
      public static var test2:int = 50000;
      
      public static var qiuYaoBaoXiang:int = 56977;
      
      public static var vecTianMing:Vector.<int> = new <int>[56978,56979,56980];
      
      private var txtPaiMing:MyTextField;
      
      private var vecStr:Vector.<String>;
      
      private var str1:String;
      
      private var str2:String;
      
      private var txtLevel:MyTextField;
      
      private var vecItem:Vector.<Item>;
      
      private var challTxt:MyTextField;
      
      private var lastTime:int;
      
      private var recTime:String;
      
      private var curTime:int;
      
      private var getDateTime:int;
      
      private var isFirst:Boolean = true;
      
      public function ShenShouPaiHang()
      {
         super();
      }
      
      public static function isShenShouPNC(sysID:int) : Boolean
      {
         if(sysID >= shenShouNPCStar && sysID <= shenShouNPCEnd)
         {
            return true;
         }
         return false;
      }
      
      override protected function initStaticView() : void
      {
         bAutoRemove = false;
         this.vecStr = new <String>[LangConfig.getWord("30067",3),LangConfig.getWord("30068",3),LangConfig.getWord("30069",3)];
         this.str1 = LangConfig.getWord("30070",3);
         this.str2 = LangConfig.getWord("30071",3);
         vecShenShouName = new <String>[LangConfig.getWord("30078",3),LangConfig.getWord("30079",3),LangConfig.getWord("30080",3)];
      }
      
      private function ini() : void
      {
         var item:Item = null;
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this,{
            "x":0,
            "y":0,
            "width":364,
            "height":220
         },Global.Img_Cdm);
         this.txtLevel = ComponentUtil.getTextField(this.vecStr[0] + this.str1,this,{
            "x":137,
            "y":5,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_HDTips",this,{
            "x":310,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_HDSeach",this,{
            "x":31,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("30072",3),this,{
            "x":44,
            "y":32,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("30073",3),this,{
            "x":151,
            "y":32,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("30074",3),this,{
            "x":233,
            "y":32,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.txtPaiMing = ComponentUtil.getTextField("",this,{
            "x":43,
            "y":180,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.challTxt = ComponentUtil.getTextField("",this,{
            "x":130,
            "y":196,
            "size":12,
            "leading":0
         });
         this.vecItem = new Vector.<Item>();
         i = 0;
         while(i < 5)
         {
            item = new Item(i);
            addChild(item);
            item.x = 44;
            item.y = 53 + (26 + 0) * i;
            this.vecItem.push(item);
            i++;
         }
         this.resetPosition();
      }
      
      public function update() : void
      {
         var s1:String = null;
         var s2:String = null;
         var t:int = Model_ShenShou_PaiHang.titleType;
         var titleType:int = Model_ShenShou_PaiHang.titleType - 1;
         if(3 > titleType && titleType >= 0)
         {
            this.txtLevel.text = this.vecStr[titleType] + this.str1;
         }
         if(Model_ShenShou_PaiHang.myPower == "0.0")
         {
            s1 = LangConfig.getWord("30081",3);
         }
         else
         {
            s1 = Model_ShenShou_PaiHang.myPower + "%";
         }
         if(Boolean(Model_ShenShou_PaiHang.myPaiHang))
         {
            s2 = LangConfig.getWord("30082",3,Model_ShenShou_PaiHang.myPaiHang);
         }
         else
         {
            s2 = LangConfig.getWord("30083",3);
         }
         this.txtPaiMing.htmlText = LangConfig.reTxt(this.str2,s2,s1);
         var i:int = 0;
         while(i < 5)
         {
            if(Boolean(Model_ShenShou_PaiHang.arrItem[i]))
            {
               this.vecItem[i].update(Model_ShenShou_PaiHang.arrItem[i]);
            }
            else
            {
               this.vecItem[i].reset();
            }
            i++;
         }
      }
      
      public function set challBeastTime(curT:int) : void
      {
         if(!this.visible)
         {
            return;
         }
         this.curTime = curT;
         this.recTime = DateUtil.getMSBySecond2(this.curTime);
         this.recTime = this.recTime.substr(3);
         this.getDateTime = getTimer();
         this.challTxt.htmlText = LangConfig.getWord("30102",3) + "<font color=\'#fe0000\'>" + this.recTime + "</font>";
         GameScene.instance.addFrameCallBack(this.getChallTime);
      }
      
      private function getChallTime() : void
      {
         if(this.curTime * 1000 - (getTimer() - this.getDateTime) <= 0)
         {
            GameScene.instance.removeFrameCallBack(this.getChallTime);
         }
         if(getTimer() - this.lastTime >= 1000)
         {
            this.lastTime = getTimer();
            this.recTime = DateUtil.getMSBySecond2(this.curTime - (getTimer() - this.getDateTime) / 1000);
            this.recTime = this.recTime.substr(3);
            this.challTxt.htmlText = LangConfig.getWord("30102",3) + "<font color=\'#fe0000\'>" + this.recTime + "</font>";
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirst)
            {
               this.ini();
               this.isFirst = false;
            }
            UIManager.questTraceView.visible = false;
            if(UIManager.banghuiBack.bangShenShou.visible)
            {
               UIManager.banghuiBack.visible = false;
            }
            if(UIManager.feedBeast.visible)
            {
               UIManager.feedBeast.visible = false;
            }
            if(UIManager.special_btn.visible)
            {
               UIManager.special_btn.visible = false;
            }
            ShenshouCGMessage.CG_SHEN_SHOU();
         }
         else
         {
            UIManager.questTraceView.visible = true;
            UIManager.special_btn.visible = true;
            GameScene.instance.removeFrameCallBack(this.getChallTime);
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = 190 + 20;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Sprite;
import flash.text.TextFormatAlign;

class Item extends Sprite
{
   
   private var txtPaiMing:MyTextField;
   
   private var txtName:MyTextField;
   
   private var txtPensent:MyTextField;
   
   public function Item(index:int)
   {
      super();
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":21,
         "width":270,
         "height":2
      },Global.Img_Cdm);
      this.txtPaiMing = ComponentUtil.getTextField("0" + (index + 1),this,{
         "x":5,
         "y":0,
         "color":16777215,
         "size":12,
         "leading":0
      });
      this.txtName = ComponentUtil.getTextField("",this,{
         "x":82,
         "y":0,
         "color":8896312,
         "size":12,
         "leading":0
      });
      this.txtName.realWidth = 78;
      this.txtName.align = TextFormatAlign.CENTER;
      this.txtName.text = "玩家中文名字";
      this.txtPensent = ComponentUtil.getTextField("",this,{
         "x":217 - 28,
         "y":0,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this.txtPensent.realWidth = 85;
      this.txtPensent.align = TextFormatAlign.CENTER;
      this.txtPensent.text = "10%";
   }
   
   public function reset() : void
   {
      this.txtName.text = "";
      this.txtPensent.text = "";
   }
   
   public function update(data:Array) : void
   {
      this.txtName.text = data[0];
      this.txtPensent.text = data[1] + "%";
   }
}
