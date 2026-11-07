package com.yiTian.view.modules.paihang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_KuaFuFlower;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.PaiHangCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class KuaFuMeiLiPanel extends Panel123
   {
      
      private static var _instance:KuaFuMeiLiPanel;
      
      public static const FRAME:String = "KuaFuMeiLiPanelFrame";
      
      private static const LEN:int = 7;
      
      public static var nowChooseSex:String = "woman";
      
      private var back:ScaleBitmap;
      
      private var manBtn:TabButton;
      
      private var womanBtn:TabButton;
      
      private var shuaxinBtn:Button;
      
      private var lastWeek:MyTextField;
      
      private var thisWeek:MyTextField;
      
      private var flowertf:MyTextField;
      
      private var nowPage:int = 1;
      
      private var maxPage:int;
      
      private var pageArr:Vector.<RoleItem> = new Vector.<RoleItem>();
      
      private var pageTf:MyTextField;
      
      private var lastPageBtn:Button;
      
      private var nextPageBtn:Button;
      
      public var week:int = 1;
      
      private var vec:Vector.<RoleItem> = new Vector.<RoleItem>();
      
      private var itemxArr:Array = [88,194,264,152,49,201];
      
      private var itemyArr:Array = [97,133,213,263,325,364];
      
      private var firstRoleItem:RoleItem;
      
      private var idArr:Array = [44767,44768,44769,44770,44771];
      
      private var dataArr:Array = [];
      
      private var now:TabButton;
      
      private var realExitItemArr:Array = [];
      
      private var timeOutN:int;
      
      private var timeOutM:int;
      
      public function KuaFuMeiLiPanel()
      {
         super();
         regResource("lang/ch/KFSH_Imgs.swf","KFSH_Imgsdm");
      }
      
      public static function get instance() : KuaFuMeiLiPanel
      {
         if(!_instance)
         {
            _instance = new KuaFuMeiLiPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var tipBtn:Button;
         var arr:Array;
         var i:int;
         var tf:MyTextField = null;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":694,
            "height":530
         },Global.Img_Cdm);
         move = new Rectangle(0,0,668,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":646,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":32,
            "y":48,
            "width":604,
            "height":434
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_KFXH",this,{
            "x":34,
            "y":50
         },Global.KFSH_Imgsdm);
         ComponentUtil.getBitmap("Back_ZPX",this,{
            "x":504,
            "y":75
         },Global.KFSH_Imgsdm);
         this.firstRoleItem = new RoleItem();
         ComponentUtil.setPropertie(this.firstRoleItem,{
            "x":456,
            "y":143
         });
         addChild(this.firstRoleItem);
         ComponentUtil.getBitmap("Back_JiangLi",this,{
            "x":382 + 12,
            "y":238
         },Global.KFSH_Imgsdm);
         this.manBtn = ComponentUtil.getTabButton("","TabButton_Nan",this,{
            "x":325,
            "y":55,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.KFSH_Imgsdm);
         this.womanBtn = ComponentUtil.getTabButton("","TabButton_Nv",this,{
            "x":375,
            "y":55,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.KFSH_Imgsdm);
         this.manBtn.addEventListener(MouseEvent.CLICK,this.manBtnClick);
         this.womanBtn.addEventListener(MouseEvent.CLICK,this.womanBtnClick);
         this.lastWeek = ComponentUtil.getTextField("",this,{
            "x":519,
            "y":95,
            "color":1815323,
            "size":12,
            "leading":0
         });
         this.lastWeek.mouseEnabled = true;
         this.thisWeek = ComponentUtil.getTextField("",this,{
            "x":582,
            "y":95,
            "color":3407616,
            "size":12,
            "leading":0
         });
         this.thisWeek.mouseEnabled = true;
         this.lastWeek.addEventListener(TextEvent.LINK,this.textLink);
         this.thisWeek.addEventListener(TextEvent.LINK,this.textLink);
         ComponentUtil.getTextField("第1名",this,{
            "x":418 + 12,
            "y":285,
            "color":15845526,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("第2名",this,{
            "x":418 + 12,
            "y":312,
            "color":15845526,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("第3名",this,{
            "x":418 + 12,
            "y":337,
            "color":15845526,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("第4至10名",this,{
            "x":418 + 12,
            "y":363,
            "color":15845526,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("第11名至43名",this,{
            "x":418 + 12,
            "y":389,
            "color":15845526,
            "size":12,
            "leading":0
         });
         this.flowertf = ComponentUtil.getTextField("",this,{
            "x":418 + 12,
            "y":418,
            "color":13412734,
            "size":12,
            "leading":4,
            "realWidth":194,
            "multiline":true,
            "wordWrap":true,
            "realHeight":40
         });
         this.flowertf.htmlText = "注：跨服鲜花榜每半小时刷新1次<br>      统计时间截止在星期日24:00";
         this.lastPageBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":273,
            "y":487,
            "textColor":16184781
         },Global.Img_Cdm);
         this.nextPageBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":374,
            "y":487,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":299,
            "y":486,
            "width":70,
            "height":22
         },Global.Img_Cdm);
         this.pageTf = ComponentUtil.getTextField("00/00",this,{
            "x":316,
            "y":487,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_KFXH",this,{
            "x":254,
            "y":5
         },Global.KFSH_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":657,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         tipBtn = ComponentUtil.getButton("","Button_GTH",this,{
            "x":597 + 12,
            "y":256
         },Global.KFSH_Imgsdm);
         TipManager.bind(tipBtn,Model_kuafuMeili.descrip);
         CloseButton.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         arr = ["人气礼包","魅力礼包","达人礼包","风流礼包","时尚礼包"];
         i = 0;
         while(i < 5)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":549 + 12,
               "y":285 + i * 27,
               "color":16383744,
               "size":12,
               "leading":0,
               "tabIndex":i
            });
            tf.htmlText = HtmlUtil.font(arr[i],Model_shop.get_color_arr[4 - i]);
            tf.mouseEnabled = true;
            tf.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
            {
               overHd((e.target as MyTextField).tabIndex);
            });
            tf.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
            {
               outHd();
            });
            i++;
         }
         ComponentUtil.getBitmap("Line",this,{
            "x":418,
            "y":307
         },Global.KFSH_Imgsdm);
         ComponentUtil.getBitmap("Line",this,{
            "x":418,
            "y":333
         },Global.KFSH_Imgsdm);
         ComponentUtil.getBitmap("Line",this,{
            "x":418,
            "y":385
         },Global.KFSH_Imgsdm);
         ComponentUtil.getBitmap("Line",this,{
            "x":418,
            "y":411
         },Global.KFSH_Imgsdm);
         ComponentUtil.getBitmap("Line",this,{
            "x":418,
            "y":359
         },Global.KFSH_Imgsdm);
         this.lastPageBtn.addEventListener(MouseEvent.CLICK,this.lastPage);
         this.nextPageBtn.addEventListener(MouseEvent.CLICK,this.nextPage);
      }
      
      private function overHd(type:int) : void
      {
         var vo:Vo_item = new Vo_item();
         vo.id = this.idArr[type];
         vo.Init_lib();
         TipManager.update(vo);
         TipManager.view_tip.x = Global.stage.mouseX;
         TipManager.view_tip.y = Global.stage.mouseY;
      }
      
      private function outHd() : void
      {
         TipManager.hide();
      }
      
      private function textLink(e:TextEvent) : void
      {
         var ss:String = e.text;
         if(ss == "lastWeek")
         {
            PaiHangCGMessage.CG_KUAFU_FLOWERS(2);
         }
         else if(ss == "thisWeek")
         {
            PaiHangCGMessage.CG_KUAFU_FLOWERS(1);
         }
      }
      
      public function set isLastWeek(value:int) : void
      {
         this.week = value;
         if(this.week == 2)
         {
            this.lastWeek.htmlText = "上周排行";
            this.lastWeek.color = 3407616;
            this.thisWeek.htmlText = HtmlUtil.link(HtmlUtil.underLine("本周排行"),"thisWeek");
            this.thisWeek.color = 1815323;
         }
         else if(this.week == 1)
         {
            this.thisWeek.htmlText = "本周排行";
            this.thisWeek.color = 3407616;
            this.lastWeek.htmlText = HtmlUtil.link(HtmlUtil.underLine("上周排行"),"lastWeek");
            this.lastWeek.color = 1815323;
         }
      }
      
      public function updata(arr:Array) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         this.firstRoleItem.clear();
         this.firstRoleItem.updata(arr[0],1);
         this.dataArr = arr;
         var len:int = int(this.dataArr.length);
         if(len <= LEN)
         {
            this.maxPage = 1;
         }
         else
         {
            this.maxPage = int(len / 7) + 1;
         }
         this.pageupdata(this.nowPage);
      }
      
      public function set manWomenChoose(value:String) : void
      {
         if(value == "woman")
         {
            this.womanBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            this.manBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         nowChooseSex = value;
      }
      
      private function manBtnClick(e:MouseEvent) : void
      {
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         this.manBtn.choose = true;
         this.now = this.manBtn;
         nowChooseSex = "man";
         this.updata(Model_KuaFuFlower.manArr);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.now = null;
         }
      }
      
      private function womanBtnClick(e:MouseEvent) : void
      {
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         this.womanBtn.choose = true;
         this.now = this.womanBtn;
         nowChooseSex = "woman";
         this.updata(Model_KuaFuFlower.womanArr);
      }
      
      private function nextPage(e:MouseEvent) : void
      {
         if(this.nowPage < this.maxPage)
         {
            ++this.nowPage;
            this.pageupdata(this.nowPage);
         }
      }
      
      private function lastPage(e:MouseEvent) : void
      {
         if(this.nowPage > 1)
         {
            --this.nowPage;
            this.pageupdata(this.nowPage);
         }
      }
      
      private function remove() : void
      {
         var rItem:RoleItem = null;
         clearTimeout(this.timeOutN);
         clearTimeout(this.timeOutM);
         while(Boolean(this.pageArr.length))
         {
            rItem = this.pageArr.pop();
            rItem.dispose();
         }
      }
      
      private function add() : void
      {
         var item:RoleItem = null;
         for each(item in this.pageArr)
         {
            item.show(this);
         }
      }
      
      private function pageupdata(page:int) : void
      {
         var voo:FlowerVO = null;
         var rItem:RoleItem = null;
         var pro:Object = null;
         this.pageTf.text = page + "/" + this.maxPage;
         this.remove();
         this.realExitItemArr.length = 0;
         var i:int = (this.nowPage - 1) * (LEN - 1) + 1;
         var j:int = 0;
         while(i < page * (LEN - 1) + 1)
         {
            voo = this.dataArr[i];
            rItem = RoleItem.instance;
            rItem.updata(voo,i + 1);
            pro = {
               "x":this.itemxArr[j],
               "y":this.itemyArr[j]
            };
            ComponentUtil.setPropertie(rItem,pro);
            this.pageArr.push(rItem);
            if(Boolean(voo))
            {
               this.realExitItemArr.push(rItem);
            }
            i++;
            j++;
         }
         this.add();
         this.showClidEff(0);
         this.showEff(true);
      }
      
      private function showClidEff(_index:int) : void
      {
         var rItem:RoleItem = null;
         if(!this.realExitItemArr.length || this.week == 2)
         {
            return;
         }
         if(_index >= this.realExitItemArr.length)
         {
            _index = 0;
         }
         rItem = this.realExitItemArr[_index];
         rItem.showCliSendFlwEff();
         this.timeOutN = setTimeout(function(idx:int):void
         {
            clearTimeout(timeOutN);
            rItem.hideCliSwndFlwEff();
            showClidEff(++idx);
         },3000,_index);
      }
      
      private function showEff(value:Boolean) : void
      {
         if(!this.firstRoleItem.isShowEff || this.week == 2)
         {
            return;
         }
         if(value)
         {
            this.firstRoleItem.showCliSendFlwEff();
         }
         else
         {
            this.firstRoleItem.hideCliSwndFlwEff();
         }
         this.timeOutM = setTimeout(function():void
         {
            clearTimeout(timeOutM);
            showEff(!value);
         },2000);
      }
   }
}

