package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_hzTribute extends Panel123
   {
      
      private static var numTf:MyTextField;
      
      public static var num:int;
      
      private static var LEN:int = 6;
      
      private static var tfStrH:String = "<font color=\'#fe0000\'><b>" + "必须在本页面开通或续费" + "</b></font>" + "黄钻豪华版，" + "一次可获得一个黄钻至尊礼包（<font color=\'#fe0000\'><b>随机开出以下六种奖励之一</b></font>），" + "每天可获得5个至尊礼包，次日重置，礼包以邮件" + "形式发送会有延迟，请稍等！";
      
      private static var tfStrL:String = "<font color=\'#fe0000\'><b>" + "必须在本页面开通或续费" + "</b></font>" + "蓝钻特权，" + "一次可获得一个蓝钻至尊礼包（<font color=\'#fe0000\'><b>随机开出以下六种奖励之一</b></font>），" + "每天可获得5个至尊礼包，次日重置，礼包以邮件" + "形式发送会有延迟，请稍等！" + "<font color=\'#fe0000\'><b>" + "豪华蓝钻在本次活动范围内。" + "</b></font>";
      
      private static var tfStrHZ:String = "活动期间，已开通红钻的用户可免费领取礼包1个，未开通的用户只需通过此页面开通红钻特权，即可参与本次活动。" + "<font color=\'#fe0000\'><b>" + "（开通红钻成功后，请下线重新登陆）" + "如有延迟，请耐心等候。" + "</font></b>";
      
      private static const numStr:String = "今日获得{0}/5个";
      
      public static var isInit:Boolean = false;
      
      public static var sendType:String = "";
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var isBtnEnabled:Boolean = false;
      
      private var hzUrl:String;
      
      private var btnKT:Button;
      
      private var btnKTNF:Button;
      
      private var btnStrK:String;
      
      private var btnStrKN:String;
      
      private var btnStrX:String;
      
      private var btnStrXN:String;
      
      private var gap:int = 0;
      
      private var dataArr:Array = [[46011,0,3],[43062,0,1],[43002,0,1]];
      
      private var timeStr:String;
      
      public function View_hzTribute()
      {
         super();
         regResource("lang/ch/HZXianLi.swf","HZXianLidm");
      }
      
      public static function set times(value:int) : void
      {
         var ss:String = null;
         num = value;
         if(Boolean(numTf))
         {
            ss = numStr.replace("{0}",num);
            numTf.text = ss;
         }
      }
      
      public function set hzGetStatus(value:Boolean) : void
      {
         this.isBtnEnabled = value;
         if(Boolean(this.btnKTNF))
         {
            this.btnKTNF.enabled = value;
         }
      }
      
      public function set statusHZ(value:Boolean) : void
      {
         if(value)
         {
            this.hzUrl = "bt_HongZuan08";
         }
         else
         {
            this.hzUrl = "bt_HongZuan";
         }
      }
      
      override protected function initUI2() : void
      {
         var btnClose:Button;
         var time:String;
         var timetf:MyTextField;
         var tfde:MyTextField;
         var ssTitle:String = null;
         var ssItem:String = null;
         var sDescrip:String = null;
         var weiTiao:int = 0;
         var i:int = 0;
         var gr:View_Grid = null;
         if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
         {
            ComponentUtil.getBitmap("HZXianLi_2",this,{
               "x":0,
               "y":0
            },Global.HZXianLidm);
         }
         else
         {
            ComponentUtil.getBitmap("HZXianLi",this,{
               "x":0,
               "y":0
            },Global.HZXianLidm);
         }
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            sDescrip = tfStrH + HtmlUtil.link(HtmlUtil.font(HtmlUtil.underLine(HtmlUtil.bold("续费豪华版黄钻拥有更多特权")),"#fe0000"),"haoHuaLink");
            ssTitle = "haoHuaHZ";
            ssItem = "HuangItem";
            this.btnStrK = "haoHuaHZBtnX";
            this.btnStrX = "haoHuaHZBtnX";
            this.btnStrKN = this.btnStrX = "Button_HYKT";
            this.gap = 12;
            this.showBtn(GameUnitManager.hero.huangZuanLvl > 0);
         }
         else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
         {
            sDescrip = tfStrL;
            ssTitle = "LZTitle";
            ssItem = "LanItem";
            this.btnStrK = "Button_BuleKT";
            this.btnStrX = "Button_BuleXF";
            this.btnStrKN = this.btnStrXN = "Button_GHYKT";
            this.gap = 0;
            this.showBtn(GameUnitManager.hero.ylDiaLvl > 0);
         }
         else if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            sDescrip = tfStrHZ;
            ssTitle = "Txt_HongZhuan";
            ssItem = "Txt_HongZhuanLiBao";
            if(Boolean(this.btnKT) && contains(this.btnKT))
            {
               removeChild(this.btnKT);
            }
            if(Boolean(this.btnKTNF) && contains(this.btnKTNF))
            {
               removeChild(this.btnKTNF);
            }
            this.btnKT = ComponentUtil.getButton("",this.hzUrl,this,{
               "x":63 + 16,
               "y":360,
               "textColor":16184781
            },Global.HZXianLidm);
            this.btnKTNF = ComponentUtil.getButton("","bt_HongZuanLQ",this,{
               "x":221 + 16,
               "y":360,
               "textColor":16184781
            },Global.HZXianLidm);
            this.btnKTNF.enabled = this.isBtnEnabled;
            this.btnKT.callBack = function(e:MouseEvent):void
            {
               sendType = "self";
               YellowDiaManager.buy();
            };
            this.btnKTNF.callBack = function(e:MouseEvent):void
            {
               YelloDiaCGMessage.CG_LINGQU_AWARD();
            };
         }
         ComponentUtil.getBitmap(ssTitle,this,{
            "x":0,
            "y":0
         },Global.HZXianLidm);
         ComponentUtil.getBitmap(ssItem,this,{
            "x":79,
            "y":247
         },Global.HZXianLidm);
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE)
         {
            ComponentUtil.getBitmap("descripIcon",this,{
               "x":34,
               "y":233
            },Global.HZXianLidm);
         }
         btnClose = ComponentUtil.getButton("","Button_HDClose",this,{
            "x":458,
            "y":5
         });
         btnClose.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         time = "";
         if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            weiTiao = 24;
            LEN = 3;
            time = "限全服领取10万份礼包";
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE)
         {
            weiTiao = 0;
            LEN = 6;
            time = Global.huangZTimeCtr;
         }
         else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
         {
            weiTiao = 0;
            LEN = 6;
            time = Model_txAction.hzStrAdd == "" ? "参数没有" : Model_txAction.hzStrAdd;
         }
         else
         {
            weiTiao = 0;
            LEN = 6;
            time = "11月21号00:00-11月28号24:00";
         }
         timetf = ComponentUtil.getTextField("",this,{
            "x":131,
            "y":102,
            "color":9319432,
            "size":12,
            "leading":0,
            "filters":[]
         });
         timetf.htmlText = time;
         tfde = ComponentUtil.getTextField("",this,{
            "x":131,
            "y":122,
            "color":9319432,
            "size":12,
            "leading":2,
            "filters":[],
            "realWidth":296,
            "multiline":true,
            "wordWrap":true
         });
         tfde.htmlText = sDescrip;
         tfde.mouseEnabled = true;
         tfde.addEventListener(TextEvent.LINK,this.link);
         ComponentUtil.getTextField("（特别提示：开通/续费最短时间1个月即可获得礼包）",this,{
            "x":127,
            "y":193,
            "color":9908736,
            "size":12,
            "leading":0,
            "filters":[]
         });
         numTf = ComponentUtil.getTextField("",this,{
            "x":98,
            "y":332,
            "color":16733184,
            "size":12,
            "leading":0,
            "filters":[],
            "bold":true
         });
         i = 0;
         while(i < LEN)
         {
            gr = new View_Grid();
            gr.set_bmp_bg();
            gr.set_bmp_over(true,null);
            gr.set_tf_count(true,false,true);
            addChild(gr);
            gr.x = 250 + int(i % 3) * 49;
            gr.y = 261 + int(i / 3) * 47 + weiTiao;
            this.gridVec.push(gr);
            i++;
         }
         this.initD();
      }
      
      private function link(e:TextEvent) : void
      {
         navigateToURL(new URLRequest("http://vip.qzone.com/supervip.html"),"_blank");
      }
      
      private function showBtn(value:Boolean) : void
      {
         if(Boolean(this.btnKT))
         {
            removeChild(this.btnKT);
         }
         if(Boolean(this.btnKTNF))
         {
            removeChild(this.btnKTNF);
         }
         if(value)
         {
            this.btnKT = ComponentUtil.getButton("",this.btnStrX,this,{
               "x":63 + this.gap,
               "y":360,
               "textColor":16184781,
               "name":"self"
            },Global.HZXianLidm);
            this.btnKTNF = ComponentUtil.getButton("",this.btnStrXN,this,{
               "x":221 + this.gap,
               "y":360,
               "textColor":16184781,
               "name":"send"
            },ComponentUtil.domain);
         }
         else
         {
            this.btnKT = ComponentUtil.getButton("",this.btnStrK,this,{
               "x":63 + this.gap,
               "y":360,
               "textColor":16184781,
               "name":"self"
            },Global.HZXianLidm);
            this.btnKTNF = ComponentUtil.getButton("",this.btnStrKN,this,{
               "x":221 + this.gap,
               "y":360,
               "textColor":16184781,
               "name":"send"
            },ComponentUtil.domain);
         }
         this.btnKT.callBack = this.btnKTNF.callBack = function(e:MouseEvent):void
         {
            sendType = e.target.name;
            if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
            {
               YellowDiaManager.buy(true);
            }
            else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
            {
               YellowDiaManager.buy();
            }
            else
            {
               YellowDiaManager.buy();
            }
         };
      }
      
      private function initD() : void
      {
         var _arr:Array = null;
         var item:Vo_item = null;
         var i:int = 0;
         while(i < LEN)
         {
            _arr = [];
            if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
            {
               _arr = this.dataArr[i];
            }
            else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
            {
               _arr = Data_lib.hzTribute[i + 1];
            }
            else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
            {
               _arr = Data_lib.hzTributelanZuan[i + 1];
            }
            item = new Vo_item();
            item.id = _arr[0];
            item.Init_lib();
            item.count = _arr[2];
            this.gridVec[i].vo = item;
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            Tween.to(this,100,{
               "alpha":[0,1],
               "x":[(Global.stage.stageWidth - 480) / 2 + 50,(Global.stage.stageWidth - 480) / 2]
            });
         }
         else
         {
            Tween.to(this,100,{
               "alpha":[1,0],
               "x":[this.x,this.x + 50]
            },this.comp);
         }
      }
      
      private function comp() : void
      {
         super.visible = false;
      }
      
      public function show() : void
      {
         var ss:String = null;
         this.visible = true;
         if(numTf.text == "")
         {
            ss = numStr.replace("{0}",num);
            numTf.text = ss;
         }
         if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            numTf.text = "仅限1次";
            numTf.x = 98 + 18;
         }
      }
      
      public function updata() : void
      {
         this.timeStr = numStr;
         this.timeStr = this.timeStr.replace("{0}",num);
         if(Boolean(numTf))
         {
            numTf.text = this.timeStr;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 480) / 2;
         y = (Global.stage.stageHeight - 430) / 2;
      }
   }
}

