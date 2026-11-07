package com.yiTian.view.modules.actions
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.SingleLoader;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class HuiGui extends Sprite
   {
      
      private var cardItemVec:Vector.<CardItem> = new Vector.<CardItem>(3);
      
      private var neiRongIm:NeirongPartTwo;
      
      private var tfTime1:MyTextField;
      
      private var tfTime2:MyTextField;
      
      private var tfTime3:MyTextField;
      
      private var nowC:CardItem;
      
      private var _days_n:int = 1000;
      
      private var dataStr:String;
      
      private var iconId:String;
      
      private var iconArr:Array = ["HuiGuiJZ_01","HuiGuiJZ_02","HuiGuiJZ_03","HuiGuiJZ_04","HuiGuiJZ_05","HuiGuiJZ_06","HuiGuiJZ_07","HuiGuiJZ_08","HuiGuiJZ_09"];
      
      public function HuiGui()
      {
         super();
      }
      
      private function initUI2() : void
      {
         var cItem:CardItem = null;
         ComponentUtil.getScaleBitmap("Back_Diamond01",[11,11,1,1],this,{
            "x":176,
            "y":50,
            "width":640,
            "height":294
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":191,
            "y":147,
            "width":610,
            "height":182
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("List_Back",this,{
            "x":182,
            "y":56
         },Global.HuiGuidm);
         ComponentUtil.getBitmap("Text_HuiGui",this,{
            "x":385,
            "y":56
         },Global.HuiGuidm);
         this.tfTime1 = ComponentUtil.getTextField("活动期间，倚天特为所有归来的大侠送上大礼，有连续15天未登录过的30级以上玩家即可享受到此优惠。",this,{
            "x":186,
            "y":88,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动时间：",this,{
            "x":186,
            "y":107,
            "color":45824,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动条件：",this,{
            "x":186,
            "y":126,
            "color":45824,
            "size":12,
            "leading":0
         });
         this.tfTime3 = ComponentUtil.getTextField("2月24日-3月2日",this,{
            "x":251,
            "y":107,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.tfTime2 = ComponentUtil.getTextField("在1月1日-2月20日中途有连续3天未登陆的30级以上玩家",this,{
            "x":251,
            "y":126,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.neiRongIm = new NeirongPartTwo();
         this.neiRongIm.x = 176;
         this.neiRongIm.y = 349;
         this.neiRongIm.loadComp();
         addChild(this.neiRongIm);
         var i:int = 0;
         while(i < this.cardItemVec.length)
         {
            cItem = new CardItem();
            ComponentUtil.setPropertie(cItem,{
               "x":246 + i * 193,
               "y":162
            });
            cItem.setData(i + 1,2);
            addChild(cItem);
            cItem.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
            cItem.addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
            cItem.addEventListener(MouseEvent.CLICK,this.cliHd);
            this.cardItemVec[i] = cItem;
            i++;
         }
      }
      
      private function overHd(e:MouseEvent) : void
      {
         var cPa:CardItem = null;
         var cI:CardItem = null;
         if(!(e.target is CardItem))
         {
            cPa = e.target.parent as CardItem;
            cPa.setFilter(true);
         }
         else
         {
            cI = e.target as CardItem;
            cI.setFilter(true);
         }
      }
      
      public function updateDate() : void
      {
         this.tfTime1.text = "活动期间，倚天特为所有归来的大侠送上大礼，有连续" + Fuli.days_n + "天未登录过的30级以上玩家即可享受到此优惠";
         this.tfTime2.text = "在活动时间内，登录距离上次登录有连续" + Fuli.days_n + "天未登陆过的30级以上玩家";
      }
      
      private function outHd(e:MouseEvent) : void
      {
         var cPa:CardItem = null;
         var cI:CardItem = null;
         if(!(e.target is CardItem))
         {
            cPa = e.target.parent as CardItem;
            if(!cPa.selected)
            {
               cPa.setFilter(false);
            }
         }
         else
         {
            cI = e.target as CardItem;
            if(!cI.selected)
            {
               cI.setFilter(false);
            }
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var cI:CardItem = null;
         if(!(e.target is CardItem))
         {
            cI = e.target.parent as CardItem;
         }
         else
         {
            cI = e.target as CardItem;
         }
         if(Boolean(this.nowC))
         {
            this.nowC.setFilter(false);
            this.nowC.selected = false;
         }
         cI.setFilter(true);
         cI.selected = true;
         this.nowC = cI;
         this.initAward(this.nowC.type);
      }
      
      public function initAward(_type:int = 1) : void
      {
         var key:String = null;
         var arr:Array = null;
         var ss:String = this.getRange(GameUnitManager.hero.level);
         var dic:Dictionary = Data_lib.lwjcz;
         this.dataStr = "";
         for(key in dic)
         {
            arr = dic[key];
            if(_type == dic[key][0])
            {
               if(ss == dic[key][2])
               {
                  this.dataStr = dic[key][3];
                  this.iconId = this.iconArr[dic[key][4] - 1];
               }
            }
         }
         this.upateData(_type);
      }
      
      public function update(status1:int, status2:int, status3:int, chongZhi:int, time:String) : void
      {
         var cItem:CardItem = null;
         var _arr:Array = [status1,status2,status3];
         if(chongZhi >= 5000)
         {
            chongZhi = 5000;
         }
         this.days_n = chongZhi;
         var i:int = 0;
         while(i < this.cardItemVec.length)
         {
            cItem = this.cardItemVec[i];
            cItem.setBtnEnable(_arr[i]);
            i++;
         }
         this.cardItemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         this.updateDate();
         this.initAward();
         this.tfTime3.htmlText = time;
      }
      
      public function set days_n(value:int) : void
      {
         this._days_n = value;
         if(value >= 0 && value <= 100)
         {
            this._days_n = 100;
            this.neiRongIm.setPer(value,100);
         }
         else if(value > 100 && value <= 1000)
         {
            this._days_n = 1000;
            this.neiRongIm.setPer(value,1000);
         }
         else if(value > 1000)
         {
            this._days_n = 5000;
            this.neiRongIm.setPer(value,5000);
         }
      }
      
      public function updateSecc(sType:int) : void
      {
         var cItem:CardItem = this.cardItemVec[sType - 1];
         cItem.secc();
      }
      
      private function getRange(lvl:int) : String
      {
         if(lvl >= 30 && lvl <= 50)
         {
            return "30-50";
         }
         if(lvl >= 51 && lvl <= 70)
         {
            return "51-70";
         }
         if(lvl >= 71 && lvl <= 160)
         {
            return "71-160";
         }
         return "";
      }
      
      public function upateData(_type:int) : void
      {
         this.neiRongIm.updata(this.dataStr,this.iconId,_type);
      }
      
      public function loadComp(callB:Function) : void
      {
         if(!Global.HuiGuidm)
         {
            SingleLoader.add("lang/ch/OldPlayerHuiGui.swf",function(info:Object):void
            {
               Global.HuiGuidm = info.applicationDomain;
               initUI2();
               callB();
            });
         }
         else
         {
            this.initUI2();
            callB();
         }
      }
   }
}

