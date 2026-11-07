package com.yiTian.view.modules.xiaoxiaole
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.config.Enum_xiaoxiaole;
   import com.yiTian.data.model.Model_xiaoxiaole;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.XxlCGMessage;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mx.utils.StringUtil;
   
   public class View_xiaoxiaole extends Panel123
   {
      
      private static var instance:View_xiaoxiaole;
      
      private var mianfei:Button;
      
      private var zadan:Button;
      
      private var qingchu:Button;
      
      private var bianse:Button;
      
      private var effContainer:Sprite;
      
      private var isInit:Boolean;
      
      public var gridDic:Vector.<XXLNode> = new Vector.<XXLNode>();
      
      private var model:Model_xiaoxiaole = Model_xiaoxiaole.getInstance();
      
      private var instance0:ScaleBitmap;
      
      private var instance1:ScaleBitmap;
      
      private var instance2:Button;
      
      private var instance3:ScaleBitmap;
      
      private var instance5:ScaleBitmap;
      
      private var instance6:Bitmap;
      
      private var instance7:Bitmap;
      
      private var liansuo:MyTextField;
      
      private var zhadan:MyTextField;
      
      private var pingbuqingyun:MyTextField;
      
      private var instance15:MyTextField;
      
      private var instance17:MyTextField;
      
      private var instance24:ScaleBitmap;
      
      private var instance25:ScaleBitmap;
      
      private var instance26:MyTextField;
      
      private var instance27:MyTextField;
      
      private var instance28:Bitmap;
      
      private var lsxc:Bitmap;
      
      private var PBQY:Bitmap;
      
      private var lsxcContainer:Sprite;
      
      private var PBQYContainer:Sprite;
      
      private var Icon_DZYYContainer:Sprite;
      
      private var zdfContainer:Sprite;
      
      private var instance31:Bitmap;
      
      private var stepTxt:MyTextField;
      
      private var jpTxt:MyTextField;
      
      private var mf:MyTextField;
      
      private var yz:MyTextField;
      
      private var yb20:MyTextField;
      
      private var yb40:MyTextField;
      
      private var mapContinaer:Sprite;
      
      private var bitmpList:Array;
      
      private var libArr:Array = [];
      
      private var stepSpr:Sprite;
      
      private var jpSpr:Sprite;
      
      private var timeFlag:int;
      
      private var valueDic:Dictionary = new Dictionary();
      
      private var index:int;
      
      private var EffModel:Effect_xxl = Effect_xxl.getInstance();
      
      private var poolArr1:Array = [];
      
      private var poolArr2:Array = [];
      
      private var lastJP:int;
      
      private var lastStep:int;
      
      public function View_xiaoxiaole()
      {
         super();
         regResource("lang/ch/ChiBang.swf","ChiBangdm");
      }
      
      public static function getInstance() : View_xiaoxiaole
      {
         if(!instance)
         {
            instance = new View_xiaoxiaole();
         }
         return instance;
      }
      
      override protected function initUI2() : void
      {
         var vo:Vo_DynamicTip;
         var b:DictionaryTabel;
         var introtf:MyTextField = null;
         var k:String = null;
         this.lsxcContainer = new Sprite();
         this.PBQYContainer = new Sprite();
         this.Icon_DZYYContainer = new Sprite();
         this.zdfContainer = new Sprite();
         this.instance0 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":582,
            "height":489
         },Global.Img_Cdm);
         this.instance1 = ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":532,
            "height":439
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":547,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.instance3 = ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":508,
            "height":109
         },Global.ChiBangdm);
         this.instance5 = ComponentUtil.getScaleBitmap("Back_TuBiao",[11,11,1,1],this,{
            "x":44,
            "y":59,
            "width":345,
            "height":78
         },Global.ChiBangdm);
         this.instance6 = ComponentUtil.getBitmap("Title_JingPo",this,{
            "x":211,
            "y":6
         },Global.ChiBangdm);
         this.instance7 = ComponentUtil.getBitmap("Back_JingPo",this,{
            "x":37,
            "y":164
         },Global.ChiBangdm);
         this.liansuo = ComponentUtil.getTextField("免费",this.lsxcContainer,{
            "x":84,
            "y":110,
            "color":16772287,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.zhadan = ComponentUtil.getTextField("银子10000",this.zdfContainer,{
            "x":175,
            "y":110,
            "color":16772287,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.pingbuqingyun = ComponentUtil.getTextField("30元宝",this.PBQYContainer,{
            "x":262,
            "y":110,
            "color":16772287,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.instance15 = ComponentUtil.getTextField("20元宝",this.Icon_DZYYContainer,{
            "x":349,
            "y":110,
            "color":16772287,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.instance17 = ComponentUtil.getTextField("1000精魄=1个翅膀羽毛",this,{
            "x":396,
            "y":115,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.instance26 = ComponentUtil.getTextField("移动步数:",this,{
            "x":396,
            "y":63,
            "color":16772287,
            "size":12,
            "leading":7
         });
         ComponentUtil.getTextField("获得精魄：",this,{
            "x":396,
            "y":90,
            "color":16772287,
            "size":12,
            "leading":7
         });
         this.instance27 = ComponentUtil.getTextField("注：步数为0或者24：00自动兑换翅膀羽毛并邮件发送，24：00清除精魄值",this,{
            "x":44,
            "y":139,
            "color":327424,
            "size":12,
            "leading":0
         });
         introtf = ComponentUtil.getTextField("玩法介绍",this,{
            "x":464,
            "y":139,
            "color":16764206,
            "size":12,
            "leading":0,
            "underline":true
         });
         introtf.mouseEnabled = true;
         vo = new Vo_DynamicTip();
         vo._w = 450;
         vo.info = LangConfig.getWord("1180",0);
         TipManager.bind(introtf,vo);
         this.lsxc = ComponentUtil.getBitmap("Icon_LSXC",this.lsxcContainer,{
            "x":63,
            "y":66
         },Global.ChiBangdm);
         this.instance31 = ComponentUtil.getBitmap("Icon_TYPD",this.zdfContainer,{
            "x":150,
            "y":66
         },Global.ChiBangdm);
         this.PBQY = ComponentUtil.getBitmap("Icon_PBQY",this.PBQYContainer,{
            "x":237,
            "y":66
         },Global.ChiBangdm);
         this.instance28 = ComponentUtil.getBitmap("Icon_DZYY",this.Icon_DZYYContainer,{
            "x":324,
            "y":66
         },Global.ChiBangdm);
         this.stepSpr = new Sprite();
         this.stepSpr.x = 460;
         this.stepSpr.y = 60;
         this.addChild(this.stepSpr);
         this.jpSpr = new Sprite();
         this.jpSpr.x = 460;
         this.jpSpr.y = 90;
         this.addChild(this.jpSpr);
         ComponentUtil.getBitmap("cishu_tis",this.lsxcContainer,{
            "x":61 + 40,
            "y":70,
            "scaleX":0.9,
            "scaleY":0.9
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("cishu_tis",this.zdfContainer,{
            "x":151 + 37,
            "y":70,
            "scaleX":0.9,
            "scaleY":0.9
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("cishu_tis",this.PBQYContainer,{
            "x":241 + 38,
            "y":70,
            "scaleX":0.9,
            "scaleY":0.9
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("cishu_tis",this.Icon_DZYYContainer,{
            "x":325 + 37,
            "y":70,
            "scaleX":0.9,
            "scaleY":0.9
         },Global.ChiBangdm);
         this.mf = ComponentUtil.getTextField("10",this.lsxcContainer,{
            "x":92 - 23 + 40,
            "y":70,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.yz = ComponentUtil.getTextField("10",this.zdfContainer,{
            "x":182 - 27 + 40,
            "y":70,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.yb20 = ComponentUtil.getTextField("10",this.PBQYContainer,{
            "x":272 - 25 + 40,
            "y":70,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.yb40 = ComponentUtil.getTextField("10",this.Icon_DZYYContainer,{
            "x":362 - 32 + 40,
            "y":70,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         move = new Rectangle(0,0,537,36);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.mapContinaer = new Sprite();
         this.mapContinaer.width = Enum_xiaoxiaole.GRID_W * 12;
         this.mapContinaer.height = Enum_xiaoxiaole.GRID_W * 7;
         this.mapContinaer.x = 40;
         this.mapContinaer.y = 130;
         this.addChild(this.mapContinaer);
         this.lsxcContainer.buttonMode = this.Icon_DZYYContainer.buttonMode = this.PBQYContainer.buttonMode = this.zdfContainer.buttonMode = true;
         this.addChild(this.lsxcContainer);
         this.addChild(this.Icon_DZYYContainer);
         this.addChild(this.PBQYContainer);
         this.addChild(this.zdfContainer);
         this.lsxcContainer.addEventListener(MouseEvent.CLICK,this.onClick);
         this.Icon_DZYYContainer.addEventListener(MouseEvent.CLICK,this.onClick);
         this.PBQYContainer.addEventListener(MouseEvent.CLICK,this.onClick);
         this.zdfContainer.addEventListener(MouseEvent.CLICK,this.onClick);
         b = Data_lib.jingpodaoju;
         for(k in b)
         {
            switch(k)
            {
               case "消除连锁":
                  this.libArr[0] = b[k];
                  break;
               case "炸弹":
                  this.libArr[1] = b[k];
                  break;
               case "增加5步":
                  this.libArr[2] = b[k];
                  break;
               case "颠倒乾坤":
                  this.libArr[3] = b[k];
            }
         }
         this.bitmpList = [this.lsxc,this.instance31,this.PBQY,this.instance28];
         TipManager.bind(this.lsxcContainer,this.libArr[0][0]);
         TipManager.bind(this.zdfContainer,this.libArr[1][0]);
         TipManager.bind(this.PBQYContainer,this.libArr[2][0]);
         TipManager.bind(this.Icon_DZYYContainer,this.libArr[3][0]);
         this.lsxcContainer.addEventListener(MouseEvent.ROLL_OVER,function():void
         {
            lsxc.filters = Util.glowFFFF00;
         });
         this.lsxcContainer.addEventListener(MouseEvent.ROLL_OUT,function():void
         {
            lsxc.filters = [];
         });
         this.Icon_DZYYContainer.addEventListener(MouseEvent.ROLL_OVER,function():void
         {
            instance28.filters = Util.glowFFFF00;
         });
         this.Icon_DZYYContainer.addEventListener(MouseEvent.ROLL_OUT,function():void
         {
            instance28.filters = [];
         });
         this.PBQYContainer.addEventListener(MouseEvent.ROLL_OVER,function():void
         {
            PBQY.filters = Util.glowFFFF00;
         });
         this.PBQYContainer.addEventListener(MouseEvent.ROLL_OUT,function():void
         {
            PBQY.filters = [];
         });
         this.zdfContainer.addEventListener(MouseEvent.ROLL_OVER,function():void
         {
            instance31.filters = Util.glowFFFF00;
         });
         this.zdfContainer.addEventListener(MouseEvent.ROLL_OUT,function():void
         {
            instance31.filters = [];
         });
         this.addEventListener(MouseEvent.CLICK,XXLMouseHandler.getInstance().Click);
         this.addEventListener(MouseEvent.MOUSE_DOWN,XXLMouseHandler.getInstance().onDown);
         this.addEventListener(MouseEvent.MOUSE_UP,XXLMouseHandler.getInstance().onUp);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var str:String;
         var costs:int;
         var ck:Function;
         var execut:Function = null;
         execut = function():void
         {
            var effBmd:BitmapData;
            var effBm:Bitmap = null;
            var effBmComplete:Function = null;
            effBmComplete = function(bm:Bitmap):void
            {
               bm.scaleX = bm.scaleY = 1;
               bm.x = bm.y = 0;
               bm.alpha = 0;
               bm.bitmapData.dispose();
               bm.parent.removeChild(bm);
            };
            if(timeFlag == 0)
            {
               timeFlag = setTimeout(function():void
               {
                  clearTimeout(timeFlag);
                  timeFlag = 0;
               },2000);
               switch(index)
               {
                  case 0:
                     XxlCGMessage.CG_XXL_USE_TOOL_CLEAR();
                     break;
                  case 1:
                     XxlCGMessage.CG_XXL_USE_TOOL_PP();
                     break;
                  case 2:
                     XxlCGMessage.CG_XXL_USE_TOOL_ADDSTEP();
                     break;
                  case 3:
                     XxlCGMessage.CG_XXL_USE_TOOL_BW();
               }
               effBm = new Bitmap();
               effBmd = new BitmapData(bitmpList[index].width,bitmpList[index].height,true,0);
               effBmd.draw(bitmpList[index]);
               e.target.addChild(effBm);
               effBm.bitmapData = effBmd;
               Tween.to(effBm,1000,{
                  "alpha":[1,0],
                  "x":[bitmpList[index].x,bitmpList[index].x - effBm.width / 2],
                  "y":[bitmpList[index].y,bitmpList[index].y - effBm.height / 2],
                  "scaleX":[1,2],
                  "scaleY":[1,2]
               },effBmComplete);
               return;
            }
         };
         if(this.model.isEffect)
         {
            UIManager.centerBroadcast.addMsg("动画尚未播放完！");
            return;
         }
         this.index = 0;
         switch(e.target)
         {
            case this.lsxcContainer:
               this.index = 0;
               break;
            case this.zdfContainer:
               this.index = 1;
               break;
            case this.PBQYContainer:
               this.index = 2;
               break;
            case this.Icon_DZYYContainer:
               this.index = 3;
         }
         str = StringUtil.substitute("是否消费{0}购买道具并使用?",this.getCost(this.index,this.model.toolCounts[this.index]));
         costs = 2 + 10 - this.model.toolCounts[this.index];
         if(Boolean(this.valueDic[this.index]) || Boolean(costs == 2) || this.model.toolCounts[this.index] == 0)
         {
            execut();
         }
         else
         {
            ck = function(box:CheckBox):void
            {
               valueDic[index] = box.selected;
            };
            View_Alert.show(str,View_Alert.OK_CANCAL,execut,null,null,null,310,"","",TextFormatAlign.LEFT,true);
            View_Alert.instance.showCheckBox = ck;
         }
      }
      
      private function getCost(type:int, lv:int) : String
      {
         var k:String = null;
         var index:int = 0;
         var b:DictionaryTabel = Data_lib.jingpodaoju;
         for(k in b)
         {
            switch(k)
            {
               case "消除连锁":
                  this.libArr[0] = b[k];
                  break;
               case "炸弹":
                  this.libArr[1] = b[k];
                  break;
               case "增加5步":
                  this.libArr[2] = b[k];
                  break;
               case "颠倒乾坤":
                  this.libArr[3] = b[k];
            }
         }
         index = 1 + 10 - lv;
         if(index == 11)
         {
            return "已用完";
         }
         if(this.libArr[type][index] == 0)
         {
            return "免费";
         }
         var temp:Array = (this.libArr[type][index] as String).split("_");
         var costType:int = int(temp[0]);
         var s:String = costType == Enum_xiaoxiaole.YZ ? "银子" : (costType == Enum_xiaoxiaole.YB ? "元宝" : "免费");
         return temp[1] + s;
      }
      
      public function initUI() : void
      {
         var node:XXLNode = null;
         var i:int = 0;
         var j:int = 0;
         var grid:GeZi = null;
         if(!visible || this.model.mapData == null)
         {
            return;
         }
         this.clear();
         this.update();
         var temp:Array = this.model.mapData;
         var tempItem:Array = [];
         i = 0;
         while(i < temp.length)
         {
            tempItem = temp[i];
            j = 0;
            while(j < tempItem.length)
            {
               if(tempItem[j] != null)
               {
                  grid = Pool.getObject(GeZi);
                  node = new XXLNode(i,j,tempItem[j],grid);
                  grid.update(node);
                  grid.x = j * Enum_xiaoxiaole.GRID_W + 40;
                  grid.y = i * Enum_xiaoxiaole.GRID_H + 130;
                  this.addChild(grid);
                  this.gridDic.push(node);
               }
               j++;
            }
            i++;
         }
      }
      
      private function clear() : void
      {
         var i:int = 0;
         while(i < this.gridDic.length)
         {
            this.gridDic[i].gird.dispose();
            i++;
         }
         this.gridDic = new Vector.<XXLNode>();
      }
      
      public function createNewGrid(col:int, row:int, value:int) : void
      {
         var node:XXLNode = null;
         var grid:GeZi = Pool.getObject(GeZi);
         node = new XXLNode(col,row,value,grid);
         grid.update(node);
         grid.x = row * Enum_xiaoxiaole.GRID_W + 40;
         grid.y = col * Enum_xiaoxiaole.GRID_H + 130;
         grid.alpha = 0;
         this.addChild(grid);
         this.gridDic.push(node);
         Tween.to(grid,100,{"alpha":[0,1]});
      }
      
      public function checkWithS() : void
      {
         var step:int = 0;
         this.model.delList = this.model.checkXiaoCu();
         step = this.model.remaindStep;
         if(Boolean(this.model.delList.length) && step > 0)
         {
            XxlCGMessage.CG_XXL_CHANGEPOS(step,XXLUtil.getStrByNode(this.model.selectedNode[0]),XXLUtil.getStrByNode(this.model.selectedNode[1]),XXLUtil.getStrToSever());
         }
         else
         {
            this.EffModel.moveTwoBoy(function():void
            {
               if(step == 0)
               {
                  UIManager.centerBroadcast.addMsg("您的步数已经用完了！");
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("不可移动该棋子");
               }
               EffModel.moveTwoBoy(function():void
               {
                  model.selectedNode = new Vector.<XXLNode>();
               });
            });
         }
      }
      
      public function checkMap() : void
      {
         this.model.delList = this.model.checkXiaoCu();
         var step:int = this.model.remaindStep;
         if(Boolean(this.model.delList.length))
         {
            XxlCGMessage.CG_XXL_KILL_GIRD(step,XXLUtil.getStrToSever());
         }
         else
         {
            XxlCGMessage.CG_XXL_SYNMAP();
            if(!this.model.isCanXiaochu())
            {
               XxlCGMessage.CG_XXL_REFRESHMAP();
            }
         }
      }
      
      public function getGridByNode(node:XXLNode) : XXLNode
      {
         var i:* = undefined;
         for(i in this.gridDic)
         {
            if(this.gridDic[i].col == node.col && this.gridDic[i].row == node.row)
            {
               return this.gridDic[i];
            }
         }
         return null;
      }
      
      public function alginValue() : void
      {
         var temp:Array = null;
         var node:XXLNode = null;
         var i:* = undefined;
         if(this.model.selectedNode.length == 2)
         {
            temp = [];
            while(Boolean(this.model.selectedNode.length))
            {
               node = this.model.selectedNode.shift();
               for(i in this.gridDic)
               {
                  if(this.gridDic[i].col == node.col && this.gridDic[i].row == node.row)
                  {
                     temp.push([i,this.gridDic[i].col,this.gridDic[i].row]);
                  }
               }
            }
            if(!temp.length)
            {
               return;
            }
            this.gridDic[temp[0][0]].col = temp[1][1];
            this.gridDic[temp[0][0]].row = temp[1][2];
            this.gridDic[temp[1][0]].col = temp[0][1];
            this.gridDic[temp[1][0]].row = temp[0][2];
         }
      }
      
      public function delGird(node:XXLNode) : void
      {
         var i:* = undefined;
         for(i in this.gridDic)
         {
            if(this.gridDic[i].col == node.col && this.gridDic[i].row == node.row)
            {
               this.gridDic.splice(i,1);
               return;
            }
         }
      }
      
      public function update() : void
      {
         Effect_Strenth.setValue(this.model.remaindStep,this.stepSpr);
         Effect_Strenth.setValue(this.model.jp,this.jpSpr);
         TipManager.bind(this.stepSpr,"剩余步数：" + this.model.remaindStep);
         TipManager.bind(this.jpSpr,"精魄：" + this.model.jp);
         this.mf.htmlText = this.model.toolCounts[0] + "";
         this.liansuo.htmlText = this.getCost(0,this.model.toolCounts[0]);
         this.yz.htmlText = this.model.toolCounts[1] + "";
         this.zhadan.htmlText = this.getCost(1,this.model.toolCounts[1]);
         this.yb20.htmlText = this.model.toolCounts[2] + "";
         this.pingbuqingyun.htmlText = this.getCost(2,this.model.toolCounts[2]);
         this.yb40.htmlText = this.model.toolCounts[3] + "";
         this.instance15.htmlText = this.getCost(3,this.model.toolCounts[3]);
      }
      
      public function PPP(p:String, calls:Function) : void
      {
         var effBmComplete:Function = null;
         effBmComplete = function(bm:Bitmap):void
         {
            bm.scaleX = bm.scaleY = 1;
            bm.x = bm.y = 0;
            bm.alpha = 0;
            bm.bitmapData.dispose();
            bm.parent.removeChild(bm);
            calls();
         };
         var col:int = int(p.split("_")[0]);
         var row:int = int(p.split("_")[1]);
         var node:XXLNode = this.getGridByNode(new XXLNode(col,row,0));
         var effBm:Bitmap = new Bitmap();
         var effBmd:BitmapData = new BitmapData(this.bitmpList[1].width,this.bitmpList[1].height,true,0);
         var points:Array = [63,150,237,324];
         effBmd.draw(this.bitmpList[1]);
         this.addChild(effBm);
         effBm.bitmapData = effBmd;
         Tween.to(effBm,1000,{
            "alpha":[1,0.4],
            "x":[this.bitmpList[1].x,node.gird.x],
            "y":[this.bitmpList[1].y,node.gird.y]
         },effBmComplete);
      }
      
      public function getJPTxtPoint() : Point
      {
         return localToGlobal(new Point(this.jpSpr.x,this.jpSpr.y));
      }
      
      public function playTxt() : void
      {
         var effBmComplete:Function = null;
         effBmComplete = function(bm:Bitmap):void
         {
            var _temp_1:* = bm;
            bm.scaleY = 1;
            _temp_1.scaleX = 1;
            bm.alpha = 0;
            bm.bitmapData.dispose();
            bm.parent.removeChild(bm);
         };
         var effBm:Bitmap = new Bitmap();
         var effBmd:BitmapData = new BitmapData(this.jpTxt.width,this.jpTxt.height,true,0);
         effBmd.draw(this.jpTxt);
         this.addChild(effBm);
         effBm.bitmapData = effBmd;
         Tween.to(effBm,1000,{
            "alpha":[1,0.3],
            "x":[this.jpTxt.x,this.jpTxt.x - 20],
            "y":[this.jpTxt.y,this.jpTxt.y - 20],
            "scaleX":[1,3],
            "scaleY":[1,3]
         },effBmComplete);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(visible)
         {
            this.initUI();
         }
      }
   }
}

