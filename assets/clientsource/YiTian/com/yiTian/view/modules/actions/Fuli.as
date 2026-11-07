package com.yiTian.view.modules.actions
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Fuli extends Sprite
   {
      
      public static var days_n:int = 7;
      
      private var cardItemVec:Vector.<CardItem> = new Vector.<CardItem>(3);
      
      private var neiRongItem:NeiRongItem;
      
      private var ttTime:MyTextField;
      
      private var ttTime2:MyTextField;
      
      private var ttTime3:MyTextField;
      
      private var ttTime4:MyTextField;
      
      private var days:int = 2;
      
      private var dataStr:String;
      
      private var iconArr:Array = ["FuLiJZ_01","FuLiJZ_02","FuLiJZ_03","FuLiJZ_04","FuLiJZ_05","FuLiJZ_06","FuLiJZ_07","FuLiJZ_08","FuLiJZ_09","FuLiJZ_10","FuLiJZ_11","FuLiJZ_12","FuLiJZ_13","FuLiJZ_14","FuLiJZ_15","FuLiJZ_16","FuLiJZ_17","FuLiJZ_18","FuLiJZ_19","FuLiJZ_20","FuLiJZ_21","FuLiJZ_22","FuLiJZ_23","FuLiJZ_24","FuLiJZ_25","FuLiJZ_26","FuLiJZ_27"];
      
      private var iconId:String;
      
      private var nowC:CardItem;
      
      public function Fuli()
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
            "height":330
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":191,
            "y":182,
            "width":610,
            "height":182
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("List_Back",this,{
            "x":182,
            "y":56
         },Global.HuiGuidm);
         this.ttTime = ComponentUtil.getTextField("",this,{
            "x":186,
            "y":89,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":620,
            "multiline":true,
            "wordWrap":true
         });
         ComponentUtil.getTextField("活动时间：",this,{
            "x":186,
            "y":108 + 16,
            "color":45824,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动条件：",this,{
            "x":186,
            "y":127 + 16,
            "color":45824,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("累计登陆：",this,{
            "x":186,
            "y":146 + 16,
            "color":45824,
            "size":12,
            "leading":0
         });
         this.ttTime2 = ComponentUtil.getTextField("2月24日-3月2日",this,{
            "x":251,
            "y":108 + 16,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.ttTime3 = ComponentUtil.getTextField("在活动时间内登录距离上次登录有连续3、7、15天未登陆过的30级以上玩家",this,{
            "x":251,
            "y":127 + 16,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.ttTime4 = ComponentUtil.getTextField("您已累计登陆1天",this,{
            "x":251,
            "y":146 + 16,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_FuLi",this,{
            "x":385,
            "y":56
         },Global.HuiGuidm);
         this.neiRongItem = new NeiRongItem();
         this.neiRongItem.x = 176;
         this.neiRongItem.y = 386;
         this.neiRongItem.loadComp();
         addChild(this.neiRongItem);
         var i:int = 0;
         while(i < this.cardItemVec.length)
         {
            cItem = new CardItem();
            ComponentUtil.setPropertie(cItem,{
               "x":246 + i * 193,
               "y":197
            });
            cItem.setData(i + 1,1);
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
      
      public function initAward(__days:int) : void
      {
         var key:String = null;
         var arr:Array = null;
         var ss:String = this.getRange(GameUnitManager.hero.level);
         var dic:Dictionary = Data_lib.lwjfl;
         this.dataStr = "";
         if(days_n != 3 || days_n != 7 || days_n != 15)
         {
            if(days_n < 3)
            {
               days_n = 3;
            }
            if(days_n > 3 && days_n < 7)
            {
               days_n = 7;
            }
            if(days_n > 7 && days_n < 15)
            {
               days_n = 15;
            }
         }
         if(this.days != 1 || this.days != 2 || this.days != 3)
         {
            if(this.days < 1)
            {
               this.days = 1;
            }
            if(this.days > 3)
            {
               this.days = 3;
            }
         }
         for(key in dic)
         {
            arr = dic[key];
            if(days_n == dic[key][0])
            {
               if(__days == dic[key][1])
               {
                  if(ss == dic[key][2])
                  {
                     this.dataStr = dic[key][3];
                     this.iconId = this.iconArr[dic[key][4] - 1];
                  }
               }
            }
         }
         this.upateData(__days);
      }
      
      public function upateData(__days:int) : void
      {
         this.neiRongItem.updata(this.dataStr,this.iconId,__days);
      }
      
      public function update(time:String, noDenglu:int, denglu:int, status1:int, status2:int, status3:int) : void
      {
         var cItem:CardItem = null;
         this.ttTime.htmlText = "活动期间，倚天特为所有归来的大侠送上大礼。登录距离上次登录有连续" + noDenglu + "天未登录过的30级以上玩家即可享受到此优惠。" + HtmlUtil.font("温馨提示：","#fe0000") + "计算累计登陆天数时，请用户在每天至少登陆1次，登陆的天数才会累计。";
         this.ttTime2.text = time;
         this.ttTime3.text = "在活动时间内，登录距离上次登录有连续" + noDenglu + "天未登陆过的30级以上玩家";
         this.ttTime4.text = "您已累计登陆" + denglu + "天";
         days_n = noDenglu;
         this.days = denglu;
         var _arr:Array = [status1,status2,status3];
         var i:int = 0;
         while(i < this.cardItemVec.length)
         {
            cItem = this.cardItemVec[i];
            cItem.setBtnEnable(_arr[i]);
            i++;
         }
         this.initAward(this.days);
         this.cardItemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function getRange(lvl:int) : String
      {
         if(lvl >= 30 && lvl <= 70)
         {
            return "30-70";
         }
         if(lvl >= 71 && lvl <= 90)
         {
            return "71-90";
         }
         if(lvl >= 91 && lvl <= 160)
         {
            return "91-160";
         }
         return "";
      }
      
      public function updateSecc(sType:int) : void
      {
         var cItem:CardItem = this.cardItemVec[sType - 1];
         cItem.secc();
      }
      
      public function loadComp(callB:Function) : void
      {
         SingleLoader.add("lang/ch/OldPlayerHuiGui.swf",function(info:Object):void
         {
            Global.HuiGuidm = info.applicationDomain;
            initUI2();
            callB();
         });
      }
   }
}

