package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import Layout.GridGroup;
   import Layout.HGroup;
   import Layout.ILayout;
   import com.ui.containers.list.List;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_HuaShanTaoTai extends Panel123
   {
      
      private var bg:DisplayObjectContainer;
      
      private var bm_mainLabel:Bitmap;
      
      private var rankLayout:ILayout;
      
      private var jfbListItemArr:Array;
      
      private var btn_pre:Button;
      
      private var btn_nxt:Button;
      
      private var tf_pageInfo:MyTextField;
      
      private var list1:List;
      
      private var list2:List;
      
      private var tfGroup:ILayout;
      
      private var tf_wdzl:MyTextField;
      
      private var tf_dqjf:MyTextField;
      
      private var tf_sysm:MyTextField;
      
      private var tf_dqpm:MyTextField;
      
      private var _radioBtnArr:Array = [];
      
      private var l1:BISAIList;
      
      private var l2:BISAIList;
      
      private var _labelFlag:int = -1;
      
      private var queueBuffer:Array = [];
      
      private var curOtherData:Array = [];
      
      private var last:int;
      
      private var b:Boolean = false;
      
      public function View_HuaShanTaoTai()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":703,
            "height":533
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":655,
            "height":483
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":34,
            "y":95,
            "width":230,
            "height":418
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":269,
            "y":95,
            "width":400,
            "height":216 - 7
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":35,
            "y":96,
            "width":228,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":269,
            "y":309,
            "width":400,
            "height":146
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":269,
            "y":457,
            "width":400,
            "height":56
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":269,
            "y":457,
            "width":400,
            "height":56
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":35,
            "y":96,
            "width":228,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":270,
            "y":96,
            "width":398,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":270,
            "y":310,
            "width":398,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.bg.width - 30,
            "y":5
         },Global.Img_Cdm);
         this.bm_mainLabel = new Bitmap();
         ComponentUtil.setPropertie(this.bm_mainLabel,{
            "x":242,
            "y":5
         });
         addChild(this.bm_mainLabel);
         ComponentUtil.getButton("","Button_HDSeach",this,{
            "x":625,
            "y":5,
            "textColor":16184781,
            "callBack":this.tipClickHd
         },Global.Img_Cdm);
         bindParent = GameScene.uiLayer;
         this.createTitle();
         this.createRadioGroup();
         this.createRankViewer();
         this.createList12();
         this.createMyTF();
         super.initDynamicView();
      }
      
      private function createTitle() : void
      {
         var arr:Array = [[MyTextField,{
            "text":LangConfig.getWord("29329",2),
            "x":132,
            "y":96,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29330",2),
            "x":443,
            "y":96,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29331",2),
            "x":443,
            "y":310,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29332",2),
            "x":49,
            "y":120,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29333",2),
            "x":133,
            "y":120,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29334",2),
            "x":217,
            "y":120,
            "color":16764206
         }]];
         var len:int = int(arr.length);
         ViewerCreator.createViewer(arr,this);
      }
      
      private function createRadioGroup() : void
      {
         var labelStr:String = null;
         var rb:CheckBoxxx = null;
         var labels:Array = HuaShanUtil.labelsArr;
         var vGroup:GridGroup = new GridGroup(90,72,0,0,0,-23,0,113,5);
         var len:int = int(labels.length);
         var i:int = 0;
         while(i < len)
         {
            labelStr = labels[i];
            rb = new CheckBoxxx("","CheckBox01",Global.Img_Cdm);
            rb.htmlText = labelStr;
            rb.tabIndex = i + 1;
            addChild(rb);
            vGroup.appendItem(rb);
            this._radioBtnArr.push(rb);
            i += 1;
         }
         this._radioBtnArr[0].selected = true;
         vGroup.align();
      }
      
      private function createRankViewer() : void
      {
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "width":220,
            "height":2,
            "x":40,
            "y":142
         },Global.Img_Cdm);
         this.rankLayout = new HGroup(40,150,100,200,27.5,0);
         (this.rankLayout as HGroup).type = HGroup.TOP;
         this.jfbListItemArr = [];
         this.btn_pre = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":94,
            "y":483
         },Global.Img_Cdm);
         this.tf_pageInfo = ComponentUtil.getTextField("",this,{
            "x":146,
            "y":485,
            "color":14662240
         });
         this.tf_pageInfo.autoSize = TextFieldAutoSize.CENTER;
         this.tf_pageInfo.text = "1/1";
         this.btn_nxt = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":183,
            "y":483
         },Global.Img_Cdm);
         this.btn_pre.callBack = this.preClickHd;
         this.btn_nxt.callBack = this.nxtClickHd;
      }
      
      private function tipClickHd(event:MouseEvent) : void
      {
         var pnl:View_HuaShanRulePanel2 = null;
         pnl = Singleton.getInstance(View_HuaShanRulePanel2);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.visible = !pnl.visible;
         });
      }
      
      private function preClickHd(event:MouseEvent) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         if(model.phbPageIndex <= 1)
         {
            return;
         }
         HuaShanCGMessage.CG_HS_GET_RANKS_INFO(model.bangType,model.phbPageIndex - 1,2);
      }
      
      private function nxtClickHd(event:MouseEvent) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         if(model.phbPageIndex >= model.phbMaxPage)
         {
            return;
         }
         HuaShanCGMessage.CG_HS_GET_RANKS_INFO(model.bangType,model.phbPageIndex + 1,2);
      }
      
      private function createList12() : void
      {
         var __x:Number = NaN;
         var layout:HGroup = null;
         __x = 280;
         layout = new HGroup(0,0,350,145,30,0);
         layout.type = HGroup.TOP;
         this.l1 = new BISAIList(378,180,"RIGHT");
         this.l1.itemCla = ZMListItem;
         this.l1.layout = layout;
         this.l1.x = __x;
         this.l1.y = 117;
         this.l2 = new BISAIList(378,120,"RIGHT");
         this.l2.layout = layout;
         this.l2.x = __x;
         this.l2.y = 330;
         this.l2.itemCla = ZMListItem;
         addChild(this.l1);
         addChild(this.l2);
      }
      
      private function createMyTF() : void
      {
         this.tfGroup = new GridGroup(290,463,200,70,0,25,0,250,2);
         this.tf_wdzl = ComponentUtil.getTextField("",this,{"color":16776960});
         this.tf_dqjf = ComponentUtil.getTextField("",this,{"color":16776960});
         this.tf_sysm = ComponentUtil.getTextField("",this,{"color":16776960});
         this.tf_dqpm = ComponentUtil.getTextField("",this,{"color":16776960});
         this.tfGroup.appendSomeItem(this.tf_wdzl,this.tf_dqjf,this.tf_sysm,this.tf_dqpm);
         this.tfGroup.align();
      }
      
      public function updateMainLabel() : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         if(this._labelFlag != model.type)
         {
            this._labelFlag = model.type;
            switch(model.type)
            {
               case 1:
                  this.bm_mainLabel.bitmapData = ComponentUtil.getBitmapData("Title_BenQu",Global.kuafuzhan_Imgsdm);
                  break;
               case 2:
                  this.bm_mainLabel.bitmapData = ComponentUtil.getBitmapData("Title_QuanFu",Global.kuafuzhan_Imgsdm);
                  break;
               default:
                  throw new Error("huashan type error" + model.type);
            }
         }
      }
      
      public function updateType() : void
      {
         var radioBtn:CheckBoxxx = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         var bangType:int = model.bangType;
         for each(radioBtn in this._radioBtnArr)
         {
            radioBtn.selected = bangType == radioBtn.tabIndex;
         }
      }
      
      public function updateRanks(dataArr:Array) : void
      {
         var obj:Object = null;
         var i:int = 0;
         var arr:Array = null;
         var item:JiFenBangItem = null;
         var pm:int = 0;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         var curPage:int = model.phbPageIndex;
         var maxPage:int = model.phbMaxPage;
         this.rankLayout.clearItem();
         for each(obj in this.jfbListItemArr)
         {
            removeChild(obj as DisplayObject);
            Pool.saveObject(obj);
         }
         this.jfbListItemArr.splice(0);
         i = 0;
         for each(arr in dataArr)
         {
            item = Pool.getObject(JiFenBangItem) as JiFenBangItem;
            pm = (model.phbPageIndex - 1) * HuaShanUtil.NUMLISTPAIHANG + i + 1;
            arr.push(pm);
            item.update(arr,model.type);
            this.jfbListItemArr.push(item);
            this.rankLayout.appendItem(item);
            addChild(item);
            i += 1;
         }
         this.tf_pageInfo.text = curPage.toString() + "/" + maxPage.toString();
         this.rankLayout.align();
      }
      
      public function updateMyInfo() : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         var v:Boolean = model.myBangType >= 1;
         if(!v)
         {
            this.tf_wdzl.htmlText = LangConfig.getWord("29335",2) + "：";
            this.tf_dqjf.htmlText = LangConfig.getWord("29336",2) + "：";
            this.tf_sysm.htmlText = LangConfig.getWord("29337",2) + "：";
            this.tf_dqpm.htmlText = LangConfig.getWord("29338",2) + "：";
         }
         else
         {
            this.tf_wdzl.htmlText = LangConfig.getWord("29335",2) + "：" + HuaShanUtil.labelsArr[model.myBangType - 1];
            this.tf_dqjf.htmlText = LangConfig.getWord("29336",2) + "：" + model.curScore;
            this.tf_sysm.htmlText = LangConfig.getWord("29337",2) + "：" + model.remainLife;
            this.tf_dqpm.htmlText = LangConfig.getWord("29338",2) + "：" + model.myCurRank;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            this.updateOtherList([],false,true);
         }
         if(value != super.visible)
         {
            super.visible = value;
         }
      }
      
      public function updateOtherList(data:Array, bPlay:Boolean = true, bClear:Boolean = false) : void
      {
         if(bClear)
         {
            this.queueBuffer.splice(0);
            this.curOtherData.splice(0);
            this.l1.source = [];
         }
         if(bPlay)
         {
            this.queueBuffer = this.queueBuffer.concat(data);
            this.play();
         }
         else
         {
            if(data.length >= HuaShanUtil.OTHERLISTMAXITEM)
            {
               data.splice(HuaShanUtil.OTHERLISTMAXITEM - 1);
            }
            this.l1.source = data;
            this.stop();
         }
      }
      
      public function updateGRList(obj:Object) : void
      {
         this.l2.source = obj as Array;
      }
      
      private function play() : void
      {
         if(this.b)
         {
            return;
         }
         addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function stop() : void
      {
         if(!this.b)
         {
            return;
         }
         removeEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function onFrame(event:Event) : void
      {
         var len:int = 0;
         var now:int = getTimer();
         if(now - this.last > HuaShanUtil.getStepTime(this.queueBuffer.length))
         {
            this.last = now;
            if(Boolean(this.queueBuffer.length))
            {
               while(this.curOtherData.length >= HuaShanUtil.OTHERLISTMAXITEM)
               {
                  this.curOtherData.splice(0,1);
               }
               this.curOtherData.push(this.queueBuffer.shift());
               len = int(this.curOtherData.length);
               this.l1.source = this.curOtherData;
            }
            else if(!this.queueBuffer.length)
            {
               this.stop();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
   }
}

import Layout.ILayout;
import com.ui.constants.ScrollAutoType;
import com.ui.containers.Canvas;
import com.ui.controls.CheckBox;
import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.manager.LangConfig;
import com.yiTian.net.message.cg.HuaShanCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Pool;
import com.yiTian.utils.Singleton;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

class BISAIList extends Canvas
{
   
   private var _layout:ILayout;
   
   private var _itemCla:Class;
   
   public function BISAIList(wid:int, hei:int, scrollDirection:String = "RIGHT", setWidth:int = 0)
   {
      super(wid,hei,scrollDirection,setWidth);
      scrollAutoType = ScrollAutoType.REMAIN;
   }
   
   override public function addChild(child:DisplayObject) : DisplayObject
   {
      super.addChild(child);
      this._layout.appendItem(child);
      return child;
   }
   
   override public function removeChild(child:DisplayObject) : DisplayObject
   {
      super.removeChild(child);
      this._layout.dependItem(child);
      return child;
   }
   
   override public function align() : void
   {
      this._layout.align();
      super.align();
   }
   
   public function set layout(l:ILayout) : void
   {
      this._layout = l;
   }
   
   public function set itemCla(cla:Class) : void
   {
      this._itemCla = cla;
   }
   
   public function set source(value:Array) : void
   {
      var child:Object = null;
      this.clear();
      var len:int = int(value.length);
      var i:int = 0;
      while(i < len)
      {
         child = Pool.getObject(this._itemCla);
         this.addChild(child as Sprite);
         child.data = value[i];
         i += 1;
      }
      this.align();
   }
   
   public function clear() : void
   {
      while(Boolean(numChildren))
      {
         this.removeChild(getChildAt(0));
      }
      this._layout.clearItem();
   }
}

class JiFenBangItem extends Sprite
{
   
   private var tf_pm:MyTextField;
   
   private var tf_roleName:MyTextField;
   
   private var tf_score:MyTextField;
   
   private var bm_line:ScaleBitmap;
   
   public function JiFenBangItem()
   {
      super();
      this.bm_line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "width":220,
         "height":2,
         "y":20
      },Global.Img_Cdm);
      this.tf_pm = ComponentUtil.getTextField("",this,{
         "realWidth":45,
         "color":14013822
      });
      this.tf_pm.autoSize = TextFieldAutoSize.CENTER;
      this.tf_roleName = ComponentUtil.getTextField("",this,{
         "x":45,
         "realWidth":120,
         "color":14013822
      });
      this.tf_roleName.autoSize = TextFieldAutoSize.CENTER;
      this.tf_score = ComponentUtil.getTextField("",this,{
         "x":165,
         "realWidth":45,
         "color":14662240
      });
      this.tf_score.autoSize = TextFieldAutoSize.CENTER;
   }
   
   public function update(value:Object, type:int) : void
   {
      var roleID:int = int(value[0]);
      var roleName:String = value[1];
      var area:String = value[2];
      var soccer:int = int(value[3]);
      var pm:int = int(value[4]);
      this.tf_pm.htmlText = Enum_BroadCastTool.instance.getBitStr(pm);
      this.tf_roleName.htmlText = Model_heFu.repsServName2(roleName + "." + area);
      this.tf_score.htmlText = soccer.toString();
   }
}

class ZMListItem extends Sprite
{
   
   private static var Win:BitmapData;
   
   private static var Lost:BitmapData;
   
   private static var VS:BitmapData;
   
   private var bm_result1:Bitmap;
   
   private var tf_roleName1:MyTextField;
   
   private var bm_vs:Bitmap;
   
   private var bm_result2:Bitmap;
   
   private var tf_roleName2:MyTextField;
   
   private var tf_checkReplay:MyTextField;
   
   private var bt:int;
   
   private var _last:int;
   
   private var _data:Object;
   
   public function ZMListItem()
   {
      var offsetY:Number = NaN;
      super();
      offsetY = 2;
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "width":347,
         "height":2,
         "y":25
      },Global.Img_Cdm);
      this.bm_result1 = new Bitmap();
      this.bm_result1.y = offsetY;
      addChild(this.bm_result1);
      this.tf_roleName1 = ComponentUtil.getTextField("",this,{
         "x":22,
         "y":2 + offsetY,
         "color":14013822
      });
      this.bm_vs = new Bitmap();
      this.bm_vs.bitmapData = this.getBmd("VS");
      this.bm_vs.x = 133;
      this.bm_vs.y = offsetY;
      addChild(this.bm_vs);
      this.bm_result2 = new Bitmap();
      this.bm_result2.x = 165;
      this.bm_result2.y = offsetY;
      addChild(this.bm_result2);
      this.tf_roleName2 = ComponentUtil.getTextField("",this,{
         "x":187,
         "y":2 + offsetY,
         "color":14013822
      });
      this.tf_checkReplay = ComponentUtil.getTextField("",this,{
         "x":310,
         "y":2 + offsetY
      });
      this.tf_checkReplay.htmlText = HtmlUtil.createLink(HtmlUtil.fontNoSize(LangConfig.getWord("29339",2),"#42A542"),false);
      this.tf_checkReplay.mouseEnabled = true;
      this.tf_checkReplay.addEventListener(MouseEvent.CLICK,this.clickHd);
   }
   
   public function getBmd(lName:String) : BitmapData
   {
      var resultBMD:BitmapData = null;
      switch(lName)
      {
         case "Win":
            if(Boolean(Win))
            {
               resultBMD = Win;
               break;
            }
            resultBMD = ComponentUtil.getBitmapData(lName,Global.kuafuzhan_Imgsdm);
            Win = resultBMD;
            break;
         case "Lost":
            if(Boolean(Lost))
            {
               resultBMD = Lost;
               break;
            }
            resultBMD = ComponentUtil.getBitmapData(lName,Global.kuafuzhan_Imgsdm);
            Lost = resultBMD;
            break;
         case "VS":
            if(Boolean(VS))
            {
               resultBMD = VS;
               break;
            }
            resultBMD = ComponentUtil.getBitmapData(lName,Global.kuafuzhan_Imgsdm);
            VS = resultBMD;
      }
      return resultBMD;
   }
   
   private function clickHd(event:MouseEvent) : void
   {
      var bang:int = 0;
      var url:String = null;
      var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
      var id1:Number = Number(this._data[1]);
      var id2:Number = Number(this._data[3]);
      var battleTime:int = int(this._data[5]);
      var now:int = getTimer();
      if(model.type == 1)
      {
         if(now - this._last > 4000)
         {
            this._last = now;
            HuaShanCGMessage.CG_HS_WATCHBATTLE1(id1,id2,battleTime);
         }
      }
      else if(model.type == 2)
      {
         bang = model.bangType;
         url = Util.rep(HuaShanUtil.taoTaiSaiRep,bang,battleTime);
         HuaShanUtil.questServ(url);
      }
   }
   
   override public function get height() : Number
   {
      return 30;
   }
   
   public function set data(value:Object) : void
   {
      this._data = value;
      var result:int = int(value[0]);
      var p1Name:String = value[2];
      var p2Name:String = value[4];
      this.tf_roleName1.htmlText = p1Name;
      this.tf_roleName2.htmlText = p2Name;
      if(result == 1)
      {
         this.bm_result1.bitmapData = this.getBmd("Win");
         this.bm_result2.bitmapData = this.getBmd("Lost");
      }
      else
      {
         this.bm_result1.bitmapData = this.getBmd("Lost");
         this.bm_result2.bitmapData = this.getBmd("Win");
      }
   }
}

class CheckBoxxx extends CheckBox
{
   
   public function CheckBoxxx(text:String, style:String, dm:ApplicationDomain = null, selected:Boolean = false)
   {
      super(text,style,dm,selected);
   }
   
   override protected function click(evt:MouseEvent) : void
   {
      var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
      if(model.bangType == tabIndex)
      {
         return;
      }
      HuaShanCGMessage.CG_HS_GET_RANKS_INFO(tabIndex,1,1);
   }
}
