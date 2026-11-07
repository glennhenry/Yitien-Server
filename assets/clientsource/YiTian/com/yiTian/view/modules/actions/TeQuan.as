package com.yiTian.view.modules.actions
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.SingleLoader;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class TeQuan extends Sprite
   {
      
      private var tfTime3:MyTextField;
      
      private var tfTime2:MyTextField;
      
      private var cardItemVec:Vector.<CardItem> = new Vector.<CardItem>(5);
      
      private var nowC:CardItem;
      
      private var iconArr:Array = ["TeQuanJZ_01","TeQuanJZ_02","TeQuanJZ_03","TeQuanJZ_04","TeQuanJZ_05"];
      
      private var dataStr:String;
      
      private var iconId:String;
      
      private var content:DaxiaHuiGuiPartThree;
      
      private var _chongzhiNum:int = 100;
      
      public function TeQuan()
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
         ComponentUtil.getBitmap("titlebg",this,{
            "x":385,
            "y":56
         },Global.HuiGuidm);
         ComponentUtil.getTextField("大侠特权",this,{
            "x":440,
            "y":56,
            "size":24,
            "bold":true,
            "color":15244309
         });
         ComponentUtil.getTextField("活动期间，倚天特为所有归来的大侠送上超级特权福利，从开服算起累计充值额度可领取不同礼包",this,{
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
         this.tfTime2 = ComponentUtil.getTextField("",this,{
            "x":251,
            "y":126,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.tfTime2.htmlText = "根据大侠们从<font color=\'#0bc488\'>开服到活动结束</font>在倚天游戏总充值额度领取不同礼包";
         var len:int = int(this.cardItemVec.length);
         this.content = new DaxiaHuiGuiPartThree();
         this.content.x = 176;
         this.content.y = 349;
         this.content.loadComp();
         addChild(this.content);
         var i:int = 0;
         while(i < len)
         {
            cItem = new CardItem();
            ComponentUtil.setPropertie(cItem,{
               "x":199 + i * 120,
               "y":162
            });
            cItem.setData(i + 1,3);
            addChild(cItem);
            cItem.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
            cItem.addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
            cItem.addEventListener(MouseEvent.CLICK,this.cliHd);
            this.cardItemVec[i] = cItem;
            i++;
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
      
      private function initAward(_type:int = 1) : void
      {
         var key:String = null;
         var dic:Dictionary = Data_lib.daxiatequan;
         this.dataStr = "";
         for(key in dic)
         {
            if(_type == dic[key][2])
            {
               this.dataStr = dic[key][1];
               this.iconId = this.iconArr[dic[key][2] - 1];
            }
         }
         this.updateData(_type);
      }
      
      public function updateSecc(sType:int) : void
      {
         var cItem:CardItem = null;
         var i:int = 0;
         while(i < this.cardItemVec.length)
         {
            cItem = this.cardItemVec[i];
            cItem.setBtnEnable(0);
            if(i == sType - 1)
            {
               cItem.secc();
            }
            i++;
         }
      }
      
      public function update(statusArr:Array, chongzhi:int, time:String) : void
      {
         var cItem:CardItem = null;
         var _arr:Array = statusArr;
         if(chongzhi >= 100000)
         {
            chongzhi = 100000;
         }
         this.chongzhiNum = chongzhi;
         var reachIndex:int = 0;
         var i:int = 0;
         while(i < this.cardItemVec.length)
         {
            cItem = this.cardItemVec[i];
            cItem.setBtnEnable(_arr[i]);
            if(_arr[i] == 1)
            {
               reachIndex++;
            }
            i++;
         }
         if(reachIndex > 0)
         {
            this.cardItemVec[reachIndex - 1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            this.cardItemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         this.initAward();
         this.tfTime3.text = time;
      }
      
      private function updateData(_type:int) : void
      {
         if(Boolean(this.content))
         {
            this.content.updata(this.dataStr,this.iconId,_type);
         }
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
      
      public function set chongzhiNum(value:int) : void
      {
         this._chongzhiNum = value;
         if(value >= 0 && value <= 100)
         {
            this.content.setPer(value,100);
         }
         else if(value > 100 && value <= 1000)
         {
            this.content.setPer(value,1000);
         }
         else if(value > 1000 && value <= 10000)
         {
            this.content.setPer(value,10000);
         }
         else if(value > 10000 && value <= 50000)
         {
            this.content.setPer(value,50000);
         }
         else if(value > 50000 && value <= 100000)
         {
            this.content.setPer(value,100000);
         }
         else
         {
            this.content.setPer(100000,100000);
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
   }
}

