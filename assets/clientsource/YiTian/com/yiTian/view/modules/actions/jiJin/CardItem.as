package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FundCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CardItem extends Sprite
   {
      
      private static var daysArr:Array = [0,1,2,4,7];
      
      private var flItemVec:Vector.<FLItem>;
      
      private var bmpJ:Bitmap;
      
      private var jiJinTypeTf:MyTextField;
      
      private var ybTf:MyTextField;
      
      private var jjTf:MyTextField;
      
      private var ttExtral:MyTextField;
      
      private var _jjType:int;
      
      private var _costYB:int;
      
      private var _costFund:int;
      
      private var FundType:String;
      
      public function CardItem()
      {
         var i:int;
         var flI:FLItem = null;
         this.flItemVec = new Vector.<FLItem>(5);
         super();
         ComponentUtil.getBitmap("Card_Back",this,{
            "x":0,
            "y":0
         },Global.JiJin_Imgsdm);
         this.bmpJ = ComponentUtil.getBitmap("Icon_JiJin_L1",this,{
            "x":56,
            "y":3
         },Global.JiJin_Imgsdm);
         this.jiJinTypeTf = ComponentUtil.getTextField("初级基金",this,{
            "x":59,
            "y":52,
            "color":327424,
            "size":14,
            "leading":0,
            "bold":true
         });
         ComponentUtil.getTextField("售价：\n总返利：\n",this,{
            "x":17 - 10,
            "y":93,
            "color":11523767,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("",this,{
            "x":83,
            "y":123,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.jjTf = ComponentUtil.getTextField("000000基金",this,{
            "x":63 - 10,
            "y":110,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.ttExtral = ComponentUtil.getTextField("",this,{
            "x":115 - 35,
            "y":117,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.ttExtral.visible = false;
         TipManager.bind(this.ttExtral,LangConfig.getWord("1160",0));
         this.ybTf = ComponentUtil.getTextField("000000元宝",this,{
            "x":57 - 12,
            "y":94,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":19,
            "y":143,
            "width":139,
            "height":25
         },Global.Img_Cdm);
         ComponentUtil.getTextField("天数",this,{
            "x":40,
            "y":144,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("返利基金",this,{
            "x":93,
            "y":144,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Buy",this,{
            "x":41,
            "y":306,
            "textColor":16184781,
            "callBack":function():void
            {
               if(GameUnitManager.hero.money < _costYB)
               {
                  UIManager.centerBroadcast.addMsg("元宝不够");
                  return;
               }
               if(FundMter.dataArrSave != 0)
               {
                  UIManager.centerBroadcast.addMsg("你已购买了" + HtmlUtil.font(FundMter.jiJinArr[FundMter.dataArrSave - 1],FundMter.colorArr[FundMter.dataArrSave],14) + "，请领取完返利后再购买！");
                  return;
               }
               View_Alert.show("你确定花费" + _costYB + "元宝购买" + FundType,View_Alert.OK_CANCAL,function():void
               {
                  UIManager.centerBroadcast.addMsg("恭喜你购买了" + FundType);
                  FundCGMessage.CG_FUND_BUY(_jjType);
               });
            }
         },Global.JiJin_Imgsdm);
         i = 0;
         while(i < this.flItemVec.length)
         {
            flI = new FLItem();
            addChild(flI);
            this.flItemVec[i] = flI;
            ComponentUtil.setPropertie(flI,{
               "x":21,
               "y":170 + 23 * i
            });
            i++;
         }
      }
      
      public function update(_type:int) : void
      {
         var dataSS:String = null;
         var item:FLItem = null;
         var ss:String = "Icon_JiJin_L" + _type;
         dataSS = FundMter.jiJinArr[_type - 1];
         this._jjType = _type;
         this.bmpJ.bitmapData = ComponentUtil.getBitmapData(ss,Global.JiJin_Imgsdm);
         this.FundType = HtmlUtil.font(dataSS,FundMter.colorArr[_type],14);
         this.jiJinTypeTf.htmlText = this.FundType;
         this._costYB = FundMter.fanLiArr[_type - 1][0];
         this._costFund = FundMter.fanLiArr[_type - 1][1];
         this.ybTf.htmlText = HtmlUtil.font(this._costYB + "元宝","#f9ff00");
         this.jjTf.htmlText = HtmlUtil.font(this._costFund + "基金+白金奖励","#f9ff00");
         var i:int = 0;
         while(i < this.flItemVec.length)
         {
            item = this.flItemVec[i];
            item.update(daysArr[i],_type);
            i++;
         }
      }
   }
}

