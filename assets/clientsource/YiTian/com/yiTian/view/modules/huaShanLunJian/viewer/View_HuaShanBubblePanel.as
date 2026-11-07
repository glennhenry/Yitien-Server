package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   
   public class View_HuaShanBubblePanel extends Panel123
   {
      
      private var bg:DisplayObjectContainer;
      
      private var lineShap:Shape;
      
      private var btn_lijie:Button;
      
      private var tf_nxtMatch:MyTextField;
      
      private var btn_team:Button;
      
      private var _tabBtnArr:Array = [];
      
      private var btn_zfRank:Button;
      
      private var numShp:Sprite;
      
      private var nodeContainer:Sprite;
      
      private var viewerArr:Array = [];
      
      private var _playerInfoArr:Array;
      
      private var bmArr:Array = [];
      
      private var _matchInfoArr:Array;
      
      public function View_HuaShanBubblePanel()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var viewerObj:Array = null;
         var __x:Number = NaN;
         var __y:Number = NaN;
         var tbtn:TabButton = null;
         viewerObj = [[Button,{
            "style":"Button_WDZhuFu",
            "x":354,
            "y":440,
            "name":"Button_MyBet",
            "callBack":this.wodezhufuClickHd
         },Global.kuafuzhan_Imgsdm],[Button,{
            "style":"Button_ZFPaiHang",
            "x":476,
            "y":440,
            "name":"Button_SJPaiHang",
            "callBack":this.zhufuRankClickHd
         },Global.kuafuzhan_Imgsdm],[Button,{
            "style":"Button_HDSeach",
            "x":850,
            "y":5,
            "textColor":16184781,
            "callBack":this.tipClickHd
         },Global.Img_Cdm]];
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":911,
            "height":544
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":863,
            "height":494
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Dargent",this,{
            "x":360,
            "y":140
         },Global.kuafuzhan_Imgsdm);
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getBitmap("Title_HSLunJian",this,{
            "x":376,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.bg.width - 30,
            "y":5
         },Global.Img_Cdm);
         var arr:Array = HuaShanUtil.labelsArr;
         var colorArr:Array = [327424,3394815,14566855];
         var linkArr:Array = ["TabButton_Ren","TabButton_Di","TabButton_Tian","TabButton_Xian","TabButton_Shen","TabButton_Xuan","TabButton_ZunBang","TabButton_MingBang","TabButton_ShiBang","TabButton_ZuBang"];
         var posArr:Array = [270,131,347,131,424,130,501,130,578,130,270,97,347,97,424,97,501,97,578,97];
         var i:int = 0;
         while(i < linkArr.length)
         {
            __x = Number(posArr[i * 2]);
            __y = Number(posArr[i * 2 + 1]);
            tbtn = ComponentUtil.getTabButton("",linkArr[i],this,{
               "x":__x,
               "y":__y,
               "tabIndex":i + 1,
               "textColor":colorArr[i],
               "chooseColor":colorArr[i]
            },Global.kuafuzhan_Imgsdm);
            this._tabBtnArr.push(tbtn);
            tbtn.addEventListener(MouseEvent.CLICK,this.tbtnClickHd);
            i += 1;
         }
         ViewerCreator.createViewer(viewerObj,this);
         this.btn_zfRank = getChildByName("Button_SJPaiHang") as Button;
         this.createNodesViewer();
         this.tf_nxtMatch = ComponentUtil.getTextField("",this,{
            "x":this.bg.width / 2,
            "y":490,
            "realWidth":0,
            "color":16776960
         });
         this.tf_nxtMatch.autoSize = TextFieldAutoSize.CENTER;
         this.btn_lijie = ComponentUtil.getButton("","Button_LiJie",this,{
            "x":586,
            "y":40,
            "callBack":this.lijieClickHd
         },Global.kuafuzhan_Imgsdm);
         this.btn_team = ComponentUtil.getButton("","Button_ZhenXing",this,{
            "x":538,
            "y":484,
            "callBack":this.btnTeamClickHd
         },Global.kuafuzhan_Imgsdm);
         this.numShp = new Sprite();
         this.numShp.y = 55;
         addChild(this.numShp);
         super.initDynamicView();
      }
      
      private function tipClickHd(e:Event) : void
      {
         var pnl:View_HuaShanRulePanel2 = null;
         pnl = Singleton.getInstance(View_HuaShanRulePanel2);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.visible = !pnl.visible;
         });
      }
      
      private function createNodesViewer() : void
      {
         var createrorIndex:int = 0;
         var yPosArr:Array = null;
         var offsetY:Number = NaN;
         var Y1:Number = NaN;
         var ar2:Array = null;
         var i:int = 0;
         var yyy:int = 0;
         var dir:int = 0;
         var sp:Sprite = null;
         this.nodeContainer = new Sprite();
         var s:Shape = ComponentUtil.getShape(910,545,16777215,0.5);
         addChild(s);
         addChild(this.nodeContainer);
         this.bg.mask = s;
         var createrorArr:Array = [PlayerBarNode,MatchNode,MatchNode,MatchNode,Match2Node,Champion];
         var len:int = HuaShanUtil.NUMBUBBLEPLAYER;
         createrorIndex = 0;
         yPosArr = [[0,1],[0.5,2],[1.5,4],[3.5,8],[7.5,16],[7.5,16]];
         var xPosArr:Array = [305,273,235,199,147,0];
         offsetY = 30;
         Y1 = 62;
         while(len > 0)
         {
            ar2 = [];
            i = 0;
            while(i < len)
            {
               yyy = i % int(len / 2);
               dir = i < len / 2 ? -1 : 1;
               sp = new (createrorArr[createrorIndex] as Class)() as Sprite;
               (sp as IBubbleMatchNodeViewer).lun = createrorIndex;
               (sp as IBubbleMatchNodeViewer).chang = i + 1;
               if(sp is Match2Node)
               {
                  (sp as Match2Node).way = dir;
               }
               else if(sp is PlayerBarNode)
               {
                  (sp as PlayerBarNode).way = dir;
               }
               sp.x = 455 + xPosArr[createrorIndex] * dir;
               sp.y = yPosArr[createrorIndex][0] * offsetY + yPosArr[createrorIndex][1] * yyy * offsetY + Y1;
               this.nodeContainer.addChild(sp);
               ar2.push(sp);
               i += 1;
            }
            createrorIndex += 1;
            len >>= 1;
            this.viewerArr.push(ar2);
         }
      }
      
      public function updateMatchPlayer() : void
      {
         var c:int = 0;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         var pInfo:Array = model.curPlayerInfoArr;
         var matchInfo:Array = model.curMatchInfoArr;
         this._playerInfoArr = pInfo;
         var len:int = int(pInfo.length);
         var myId:Number = GameUnitManager.hero.id;
         var i:int = 0;
         while(i < len)
         {
            if(HuaShanUtil.isPlayerSiftedOut(pInfo[i][Enum_HuaShan.CONT_ID],pInfo,matchInfo))
            {
               c = 8947848;
            }
            else if(HuaShanUtil.equalID(myId,pInfo[i][Enum_HuaShan.CONT_ID]))
            {
               c = 4521796;
            }
            else
            {
               c = 16776960;
            }
            (this.viewerArr[0][i] as PlayerBarNode).nameBarColor = c;
            (this.viewerArr[0][i] as PlayerBarNode).update(pInfo[i]);
            i += 1;
         }
         var bIsOverMatch:Boolean = HuaShanUtil.isMatchOver(matchInfo);
         var bIsMeSitedOut:Boolean = HuaShanUtil.isPlayerSiftedOut(GameUnitManager.hero.id,pInfo,matchInfo);
         if(bIsOverMatch || bIsMeSitedOut)
         {
            this.btn_team.visible = false;
         }
         else
         {
            this.btn_team.visible = true;
         }
      }
      
      public function updateBangType() : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         var chooseIndex:int = model.bangType2 - 1;
         var i:int = 0;
         while(i < this._tabBtnArr.length)
         {
            this._tabBtnArr[i].choose = chooseIndex == i;
            i += 1;
         }
      }
      
      public function updateJie() : void
      {
         var dbm:Bitmap = null;
         var numArr:Array = null;
         var t1Bm:Bitmap = null;
         var t2Bm:Bitmap = null;
         var bm:Bitmap = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         this.numShp.graphics.clear();
         var jie:int = model.jie;
         for each(dbm in this.bmArr)
         {
            Pool.saveObject(dbm);
            this.numShp.removeChild(dbm);
         }
         this.bmArr.splice(0);
         numArr = [];
         while(jie > 0)
         {
            numArr.unshift(jie % 10);
            jie /= 10;
         }
         if(numArr.length <= 1)
         {
            numArr.unshift(0);
         }
         t1Bm = Pool.getObject(Bitmap);
         t1Bm.bitmapData = ComponentUtil.getBitmapData("Text_KFZ",Global.kuafuzhan_Imgsdm);
         this.numShp.addChild(t1Bm);
         t1Bm.x = 0;
         this.bmArr.push(t1Bm);
         var i:int = 0;
         while(i < numArr.length)
         {
            bm = Pool.getObject(Bitmap);
            bm.bitmapData = ComponentUtil.getBitmapData("Text" + numArr[i],Global.kuafuzhan_Imgsdm);
            ComponentUtil.setPropertie(bm,{"x":90 + i * 20});
            this.numShp.addChild(bm);
            this.bmArr.push(bm);
            i += 1;
         }
         t2Bm = Pool.getObject(Bitmap);
         t2Bm.bitmapData = ComponentUtil.getBitmapData("Text_Jie",Global.kuafuzhan_Imgsdm);
         ComponentUtil.setPropertie(t2Bm,{"x":90 + i * 20});
         this.numShp.addChild(t2Bm);
         this.bmArr.push(t2Bm);
         this.numShp.x = (this.width - this.numShp.width) / 2;
      }
      
      override public function get width() : Number
      {
         return 910;
      }
      
      public function updateBubbleMathViewer() : void
      {
         var flagArr:Array;
         var i:int;
         var eArr:Array = null;
         var counter:int = 0;
         var battleCounter:int = 0;
         var dic:Dictionary = null;
         var e1:int = 0;
         var eArr1:Array = null;
         var e2:int = 0;
         var eArr2:Array = null;
         var statee:int = 0;
         var winway:int = 0;
         var arr:Array = null;
         var nodeIndex:int = 0;
         var preArr:Array = null;
         var curArr:Array = null;
         var j:int = 0;
         var arr2:Array = null;
         var winnerIndex:int = 0;
         var nodeState:int = 0;
         var curNode:IBubbleMatchNodeViewer = null;
         var indexs:Array = null;
         var node1:IBubbleMatchNodeViewer = null;
         var node2:IBubbleMatchNodeViewer = null;
         var type1:int = 0;
         var type2:int = 0;
         var bWeiTaoTai:Boolean = false;
         var bb:Boolean = false;
         var spliceNum:Function = function(aaaa:int, srcArr:Array):void
         {
            if(aaaa == 0)
            {
               return;
            }
            var dddd:int = srcArr.length - 1;
            while(dddd >= 0)
            {
               if(aaaa == srcArr[dddd])
               {
                  srcArr.splice(dddd,1);
                  break;
               }
               dddd -= 1;
            }
         };
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         var info:Array = model.curMatchInfoArr;
         var playerInfo:Array = model.curPlayerInfoArr;
         var id1:Number = 0;
         var id2:Number = 0;
         var LINEBLACK:int = 0;
         var LINEWHITE:int = 1;
         var LINEYELLOW:int = 2;
         var weiTaoPlayerInfoArr:Array = [];
         for each(eArr in playerInfo)
         {
            if(eArr[Enum_HuaShan.CONT_ID] != 0)
            {
               weiTaoPlayerInfoArr.push(eArr[Enum_HuaShan.CONT_ID]);
            }
         }
         counter = 0;
         battleCounter = 0;
         dic = new Dictionary();
         e1 = 0;
         while(e1 < info.length)
         {
            eArr1 = info[e1];
            e2 = 0;
            while(e2 < eArr1.length)
            {
               counter++;
               eArr2 = eArr1[e2];
               statee = int(eArr2[Enum_HuaShan.NODE_STATE]);
               id1 = Number(eArr2[Enum_HuaShan.NODE_ID1]);
               id2 = Number(eArr2[Enum_HuaShan.NODE_ID2]);
               if(statee == Enum_HuaShan.STATE_FINISH)
               {
                  battleCounter++;
                  winway = int(eArr2[Enum_HuaShan.NODE_WINWAY]);
                  if(winway == 1)
                  {
                     spliceNum(id2,weiTaoPlayerInfoArr);
                  }
                  else if(winway == 2)
                  {
                     spliceNum(id1,weiTaoPlayerInfoArr);
                  }
               }
               e2 += 1;
            }
            e1 += 1;
         }
         flagArr = [];
         i = info.length - 1;
         while(i >= 0)
         {
            arr = info[i];
            nodeIndex = i + 1;
            preArr = this.viewerArr[i];
            curArr = this.viewerArr[nodeIndex];
            j = 0;
            while(j < arr.length)
            {
               arr2 = arr[j];
               winnerIndex = int(arr2[Enum_HuaShan.NODE_WINWAY]);
               id1 = Number(arr2[Enum_HuaShan.NODE_ID1]);
               id2 = Number(arr2[Enum_HuaShan.NODE_ID2]);
               nodeState = int(arr2[Enum_HuaShan.NODE_STATE]);
               curNode = curArr[j];
               indexs = HuaShanUtil.getPre(j);
               node1 = preArr[indexs[0]];
               node2 = preArr[indexs[1]];
               curNode.update(arr2);
               bWeiTaoTai = false;
               bb = false;
               if(id1 == 0 || id2 == 0)
               {
                  if(id1 != 0)
                  {
                     bWeiTaoTai = this.isIDInArr(id1,weiTaoPlayerInfoArr);
                     bb = this.isIDInArr(id1,flagArr);
                     if(!bb)
                     {
                        flagArr.push(id1);
                     }
                     if(nodeState == Enum_HuaShan.STATE_READY)
                     {
                        type1 = LINEBLACK;
                     }
                     else
                     {
                        type1 = bWeiTaoTai ? LINEYELLOW : LINEWHITE;
                     }
                     type2 = LINEBLACK;
                     curNode.state = nodeState;
                  }
                  else if(id2 != 0)
                  {
                     curNode.state = !(curNode is MatchNode) ? nodeState : 1;
                     bWeiTaoTai = this.isIDInArr(id2,weiTaoPlayerInfoArr);
                     bb = this.isIDInArr(id2,flagArr);
                     if(!bb)
                     {
                        flagArr.push(id2);
                     }
                     if(nodeState == Enum_HuaShan.STATE_READY)
                     {
                        type2 = LINEBLACK;
                     }
                     else
                     {
                        type2 = bWeiTaoTai ? LINEYELLOW : LINEWHITE;
                     }
                     type1 = LINEBLACK;
                  }
                  else
                  {
                     curNode.state = Enum_HuaShan.STATE_NONE;
                  }
               }
               else
               {
                  switch(nodeState)
                  {
                     case Enum_HuaShan.STATE_READY:
                        type1 = type2 = LINEYELLOW;
                        curNode.state = nodeState;
                        break;
                     case 3:
                        type1 = type2 = LINEYELLOW;
                        curNode.state = nodeState;
                        break;
                     case 4:
                        if(winnerIndex == 1)
                        {
                           bWeiTaoTai = this.isIDInArr(id1,weiTaoPlayerInfoArr);
                           bb = this.isIDInArr(id2,flagArr);
                           if(!bb)
                           {
                              flagArr.push(id2);
                           }
                           type1 = bWeiTaoTai ? LINEYELLOW : LINEWHITE;
                           type2 = bb ? LINEWHITE : LINEBLACK;
                           curNode.state = nodeState;
                           break;
                        }
                        if(winnerIndex == 2)
                        {
                           bWeiTaoTai = this.isIDInArr(id2,weiTaoPlayerInfoArr);
                           bb = this.isIDInArr(id1,flagArr);
                           if(!bb)
                           {
                              flagArr.push(id1);
                           }
                           type1 = bb ? LINEWHITE : LINEBLACK;
                           type2 = bWeiTaoTai ? LINEYELLOW : LINEWHITE;
                           curNode.state = nodeState;
                        }
                        break;
                     default:
                        curNode.state = 1;
                        if(id1 != 0)
                        {
                           type1 = LINEYELLOW;
                        }
                        if(id2 != 0)
                        {
                           type2 = LINEYELLOW;
                        }
                  }
               }
               if(id1 == 0)
               {
                  type1 = LINEBLACK;
               }
               if(id2 == 0)
               {
                  type2 = LINEBLACK;
               }
               this.drawLine2(curNode,node1,type1);
               this.drawLine2(curNode,node2,type2);
               j += 1;
            }
            i -= 1;
         }
      }
      
      public function updateNxtInfo() : void
      {
         var nxtStr:String = null;
         var nxtTime:int = 0;
         var date:Date = null;
         var nxtLun:int = 0;
         var nxtChang:int = 0;
         var rep:String = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         var nxtInfo:Array = model.Match32ExtraInfo as Array;
         if(!nxtInfo)
         {
            nxtStr = "";
         }
         else if(nxtInfo[0] == -1)
         {
            nxtStr = "";
         }
         else
         {
            nxtTime = int(nxtInfo[0]);
            date = new Date(nxtTime * 1000);
            nxtLun = int(nxtInfo[1]);
            nxtChang = int(nxtInfo[2]);
            rep = LangConfig.getWord("29341",2);
            nxtStr = Util.rep(rep,DateUtil.dayStrings[date.day],Enum_BroadCastTool.instance.getBitStr(date.hours),Enum_BroadCastTool.instance.getBitStr(date.minutes),HuaShanUtil.lunNameArr[nxtLun]);
         }
         this.tf_nxtMatch.htmlText = nxtStr;
      }
      
      private function isIDInArr(id:Number, srcArr:Array) : Boolean
      {
         var did:Number = NaN;
         for each(did in srcArr)
         {
            if(did == id)
            {
               return true;
            }
         }
         return false;
      }
      
      private function drawLine2(a:IBubbleMatchNodeViewer, b:IBubbleMatchNodeViewer, type:int) : void
      {
         var disSub:Number = NaN;
         var obj1:DisplayObject = a as DisplayObject;
         var obj2:DisplayObject = b as DisplayObject;
         if(a.lun == 5)
         {
            disSub = b.chang > 1 ? 65 : -65;
            this.drawLine(obj1.x + disSub,obj1.y,obj2.x,obj2.y,type);
         }
         else
         {
            this.drawLine(obj1.x,obj1.y,obj2.x,obj2.y,type);
         }
      }
      
      private function drawLine(x1:Number, y1:Number, x2:Number, y2:Number, type:int = 1) : void
      {
         switch(type)
         {
            case 1:
               this.lineShap.graphics.lineStyle(2,8033572);
               break;
            case 2:
               this.lineShap.graphics.lineStyle(2,15110144);
               break;
            default:
               this.lineShap.graphics.lineStyle(1,5002790);
         }
         this.lineShap.graphics.moveTo(x1,y1);
         this.lineShap.graphics.lineTo(x1,y2);
         if(x1 != x2)
         {
            this.lineShap.graphics.lineTo(x2,y2);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function tbtnClickHd(event:MouseEvent) : void
      {
         var target:TabButton = event.target as TabButton;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(model.bangType2 == target.tabIndex)
         {
            return;
         }
         HuaShanCGMessage.CG_XUANBAMATCHINFO(model.jie,target.tabIndex);
      }
      
      public function playLineShp(way:int = 0, alp:Boolean = false) : void
      {
         var shp:Shape = null;
         if(alp)
         {
            this.nodeContainer.alpha = 0;
            Tween.to(this.nodeContainer,2000,{"alpha":[0,1]});
         }
         else
         {
            this.nodeContainer.alpha = 1;
         }
         if(!this.lineShap)
         {
            this.lineShap = Pool.getObject(Shape);
            this.bg.addChild(this.lineShap);
         }
         else
         {
            shp = Pool.getObject(Shape);
            if(way > 0)
            {
               shp.x = this.lineShap.x + this.lineShap.width;
               Tween.to(this.lineShap,1300,{
                  "x":[this.lineShap.x,-800],
                  "alpha":[1,0.5]
               },this.removeShp,null,Tween.EASYINOUT);
               Tween.to(shp,1300,{
                  "x":[shp.x,0],
                  "alpha":[0.5,1]
               },null,null,Tween.EASYINOUT);
            }
            else if(way < 0)
            {
               shp.x = this.lineShap.x - this.lineShap.width;
               Tween.to(this.lineShap,1300,{
                  "x":[this.lineShap.x,910 + 800],
                  "alpha":[1,0.5]
               },this.removeShp,null,Tween.EASYINOUT);
               Tween.to(shp,1300,{
                  "x":[shp.x,0],
                  "alpha":[0.5,1]
               },null,null,Tween.EASYINOUT);
            }
            else
            {
               shp.x = 0;
               this.removeShp(this.lineShap);
            }
            this.lineShap = shp;
            this.bg.addChild(this.lineShap);
         }
      }
      
      private function removeShp(target:Shape) : void
      {
         target.alpha = 1;
         target.graphics.clear();
         Pool.saveObject(target);
         this.bg.removeChild(target);
      }
      
      private function zhufuRankClickHd(event:MouseEvent) : void
      {
         var model:Model_HuaShan = null;
         var zfPnl:View_HuaShanZhuFuRank = null;
         model = Singleton.getInstance(Model_HuaShan);
         zfPnl = Singleton.getInstance(View_HuaShanZhuFuRank) as View_HuaShanZhuFuRank;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(zfPnl,function():void
         {
            zfPnl.visible = true;
            HuaShanCGMessage.CG_HS_BLESS_RANK(model.jie,model.bangType2);
         });
      }
      
      private function hsRuleClickHd(event:MouseEvent) : void
      {
         var hsRulePnl:View_HuaShanRulePanel2 = null;
         hsRulePnl = Singleton.getInstance(View_HuaShanRulePanel2) as View_HuaShanRulePanel2;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(hsRulePnl,function():void
         {
            hsRulePnl.visible = true;
         });
      }
      
      private function btnTeamClickHd(event:MouseEvent) : void
      {
         HuaShanUtil.REQTEAMINFO();
      }
      
      private function wodezhufuClickHd(event:MouseEvent) : void
      {
         var model:Model_HuaShan = null;
         var pnl:View_HuaShanWoDeZhuFu = null;
         model = Singleton.getInstance(Model_HuaShan);
         HuaShanCGMessage.CG_HS_MY_BLESSING(model.jie,model.bangType2);
         pnl = Singleton.getInstance(View_HuaShanWoDeZhuFu) as View_HuaShanWoDeZhuFu;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.visible = true;
            pnl.update(model.bangType2,model.myZhuFuInfo);
         });
      }
      
      private function lijieClickHd(event:MouseEvent) : void
      {
         var pnl:View_HuaShanLiJiePanel = Singleton.getInstance(View_HuaShanLiJiePanel);
         ModalUIManager.POPUP(pnl);
         pnl.update((Singleton.getInstance(Model_HuaShan) as Model_HuaShan).countJie);
      }
      
      public function set uiVisible(b:Boolean) : void
      {
         this.btn_zfRank.visible = b;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Const_strImg;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.ModalUIManager;
import com.yiTian.manager.TipManager;
import com.yiTian.net.message.cg.HuaShanCGMessage;
import com.yiTian.utils.Bitmap2;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Singleton;
import com.yiTian.utils.call.Delegate123;
import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
import com.yiTian.view.modules.huaShanLunJian.viewer.IBubbleMatchNodeViewer;
import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanXiaZhu;
import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanZhuFuPanel;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

class bubbleMathdeNodeViewerSP extends Sprite implements IBubbleMatchNodeViewer
{
   
   protected var _lun:int;
   
   protected var _chang:int;
   
   public function bubbleMathdeNodeViewerSP()
   {
      super();
   }
   
   public function set lun(value:int) : void
   {
      this._lun = value;
   }
   
   public function get lun() : int
   {
      return this._lun;
   }
   
   public function get chang() : int
   {
      return this._chang;
   }
   
   public function set chang(value:int) : void
   {
      this._chang = value;
   }
   
   public function update(value:Object) : void
   {
   }
   
   public function set state(value:int) : void
   {
   }
   
   public function get state() : int
   {
      return 0;
   }
   
   protected function showXiaZhu1(data:Array) : void
   {
      var xiaZhuPnl:View_HuaShanXiaZhu = null;
      var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
      var p1Info:Array = HuaShanUtil.finPlayerInfoByID(data[0],model.curPlayerInfoArr);
      var p2Info:Array = HuaShanUtil.finPlayerInfoByID(data[1],model.curPlayerInfoArr);
      var src:Array = HuaShanUtil.getXiaZhuSrc(this.lun - 1);
      if(Boolean(src))
      {
         xiaZhuPnl = Singleton.getInstance(View_HuaShanXiaZhu) as View_HuaShanXiaZhu;
         xiaZhuPnl.update(model.jie,model.bangType2,this.lun,this.chang,p1Info,p2Info);
         xiaZhuPnl.updateCombox(src);
         ModalUIManager.POPUP(xiaZhuPnl);
      }
   }
   
   protected function showZhufu(data:Array) : void
   {
      var model:Model_HuaShan = null;
      var p1Info:Array = null;
      var p2Info:Array = null;
      var viewer:View_HuaShanZhuFuPanel = null;
      model = Singleton.getInstance(Model_HuaShan);
      if(!model.myZhuFuInfo)
      {
         HuaShanCGMessage.CG_HS_MY_BLESSING(model.jie,model.bangType2);
         return;
      }
      p1Info = HuaShanUtil.finPlayerInfoByID(data[0],model.curPlayerInfoArr);
      p2Info = HuaShanUtil.finPlayerInfoByID(data[1],model.curPlayerInfoArr);
      viewer = Singleton.getInstance(View_HuaShanZhuFuPanel);
      (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewer,function():void
      {
         ModalUIManager.POPUP(viewer);
         viewer.update(model.jie,model.bangType2,lun,chang,p1Info,p2Info,true);
         viewer.choose(-1);
      });
   }
   
   protected function showChakan(data:Array) : void
   {
      var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
      model.checkPlayerReplay(this._lun,this.chang,data);
   }
}

class PlayerBarNode extends bubbleMathdeNodeViewerSP implements IBubbleMatchNodeViewer
{
   
   private var tf:MyTextField;
   
   private var bm_bg:ScaleBitmap;
   
   public function PlayerBarNode()
   {
      super();
      this.bm_bg = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "width":116,
         "height":24,
         "y":-12
      },Global.Img_Cdm);
      this.tf = ComponentUtil.getTextField("",this,{
         "y":-10,
         "realWidth":0,
         "color":16184781
      });
      this.tf.autoSize = TextFieldAutoSize.CENTER;
   }
   
   public function set nameBarColor(c:int) : void
   {
      this.tf.color = c;
   }
   
   public function set way(value:int) : void
   {
      this.tf.x = value * 57;
      this.bm_bg.x = this.tf.x - 57;
   }
   
   override public function update(data:Object) : void
   {
      if(data[Enum_HuaShan.CONT_ID] != 0)
      {
         this.tf.text = Model_heFu.repNameByHero(data[Enum_HuaShan.CONT_ROLENAME] + ".S" + data[Enum_HuaShan.CONT_SERVNAME]);
      }
      else
      {
         this.tf.text = "";
      }
   }
   
   override public function set state(value:int) : void
   {
   }
   
   override public function get state() : int
   {
      return 0;
   }
}

class MatchNode extends bubbleMathdeNodeViewerSP implements IBubbleMatchNodeViewer
{
   
   private var btnCheck:Button;
   
   private var btnBet:Button;
   
   private var _data:Array;
   
   private var _state:int = 0;
   
   public function MatchNode()
   {
      super();
   }
   
   override public function update(data:Object) : void
   {
      this._data = data as Array;
   }
   
   override public function set state(value:int) : void
   {
      var p1ID:Number = Number(this._data[Enum_HuaShan.NODE_ID1]);
      var p2ID:Number = Number(this._data[Enum_HuaShan.NODE_ID2]);
      var matchInfo:int = int(this._data[Enum_HuaShan.NODE_MATCHRESULTS]);
      if(p1ID == 0 || p2ID == 0)
      {
         value = 1;
      }
      if(this._state == value)
      {
         return;
      }
      switch(value)
      {
         case 2:
            if(!this.btnBet)
            {
               this.btnBet = ComponentUtil.getButton(LangConfig.getWord("29342",2),"Button_XiaZhu",this,{
                  "x":-17,
                  "y":-10,
                  "callBack":this.xiaZhuClickHd
               },Global.kuafuzhan_Imgsdm);
            }
            this.btnBet.visible = true;
            if(Boolean(this.btnCheck))
            {
               this.btnCheck.visible = false;
            }
            break;
         case 3:
            if(!this.btnCheck)
            {
               this.btnCheck = ComponentUtil.getButton("","Button_ChaKan",this,{
                  "x":-10,
                  "y":-10,
                  "callBack":this.chakanClickHd
               },Global.kuafuzhan_Imgsdm);
            }
            this.btnCheck.visible = true;
            if(Boolean(this.btnBet))
            {
               this.btnBet.visible = false;
            }
            break;
         case 4:
            if(!this.btnCheck)
            {
               this.btnCheck = ComponentUtil.getButton("","Button_ChaKan",this,{
                  "x":-10,
                  "y":-10,
                  "callBack":this.chakanClickHd
               },Global.kuafuzhan_Imgsdm);
            }
            this.btnCheck.visible = true;
            if(Boolean(this.btnBet))
            {
               this.btnBet.visible = false;
            }
            break;
         default:
            if(Boolean(this.btnCheck))
            {
               this.btnCheck.visible = false;
            }
            if(Boolean(this.btnBet))
            {
               this.btnBet.visible = false;
            }
      }
   }
   
   private function xiaZhuClickHd(event:MouseEvent) : void
   {
      showZhufu(this._data);
   }
   
   private function chakanClickHd(event:MouseEvent) : void
   {
      showChakan(this._data);
   }
   
   override public function get state() : int
   {
      return 0;
   }
}

class Champion extends bubbleMathdeNodeViewerSP implements IBubbleMatchNodeViewer
{
   
   private var bm_bg:Bitmap;
   
   private var shape_mask:Shape;
   
   private var bm_roleHead:Bitmap2;
   
   private var _state:int;
   
   private var _data:Array;
   
   private var tf_link:MyTextField;
   
   private var bm_text:Bitmap;
   
   public function Champion()
   {
      super();
      this.bm_bg = ComponentUtil.getBitmap("Winner_Back",this,{
         "x":-40,
         "y":-39
      },Global.kuafuzhan_Imgsdm);
      this.shape_mask = new Shape();
      this.shape_mask.graphics.beginFill(255);
      this.shape_mask.graphics.drawCircle(0,0,32);
      this.shape_mask.graphics.endFill();
      addChild(this.shape_mask);
      this.bm_roleHead = new Bitmap2();
      this.bm_roleHead.x = -31;
      this.bm_roleHead.y = -31;
      addChild(this.bm_roleHead);
      this.bm_roleHead.mask = this.shape_mask;
      this.tf_link = ComponentUtil.getTextField("",this,{
         "y":45,
         "color":11527396
      });
      this.tf_link.autoSize = TextFieldAutoSize.CENTER;
      this.tf_link.mouseEnabled = true;
      this.bm_text = new Bitmap();
      ComponentUtil.setPropertie(this.bm_text,{
         "x":-49,
         "y":-60
      });
      addChild(this.bm_text);
      buttonMode = true;
      addEventListener(MouseEvent.CLICK,this.clickHd);
   }
   
   override public function update(data:Object) : void
   {
      this._data = data as Array;
   }
   
   private function set headBMS(b:Boolean) : void
   {
      this.bm_roleHead.visible = this.bm_bg.visible = b;
   }
   
   override public function set state(value:int) : void
   {
      var model:Model_HuaShan = null;
      var url:String = null;
      var pWinIndex:int = 0;
      var id:Number = NaN;
      var roleInfo:Array = null;
      this._state = value;
      switch(value)
      {
         case 2:
            if(this._data[Enum_HuaShan.NODE_ID1] != 0 && this._data[Enum_HuaShan.NODE_ID2] != 0)
            {
               this.tf_link.htmlText = HtmlUtil.createLink(LangConfig.getWord("29342",2));
            }
            else
            {
               this.tf_link.text = "";
            }
            this.bm_text.bitmapData = null;
            this.headBMS = false;
            break;
         case 3:
            this.headBMS = true;
            break;
         case 4:
            model = Singleton.getInstance(Model_HuaShan);
            if(this._data[Enum_HuaShan.NODE_ID1] != 0 && this._data[Enum_HuaShan.NODE_ID2] != 0)
            {
               this.tf_link.htmlText = HtmlUtil.createLink(LangConfig.getWord("29343",2));
               pWinIndex = int(this._data[Enum_HuaShan.NODE_WINWAY]);
            }
            else
            {
               this.tf_link.text = "";
               pWinIndex = this._data[Enum_HuaShan.NODE_ID1] != 0 ? 1 : 2;
            }
            id = pWinIndex == 1 ? Number(this._data[Enum_HuaShan.NODE_ID1]) : Number(this._data[Enum_HuaShan.NODE_ID2]);
            roleInfo = HuaShanUtil.finPlayerInfoByID(id,model.curPlayerInfoArr);
            url = Const_strImg.getPlayerHead(roleInfo[Enum_HuaShan.CONT_ROLEJOB],roleInfo[Enum_HuaShan.CONT_ROLESEX]);
            this.bm_text.bitmapData = ComponentUtil.getBitmapData(HuaShanUtil.WINNERBMDIR[model.bangType2 - 1],Global.kuafuzhan_Imgsdm);
            this.headBMS = true;
            break;
         default:
            this.headBMS = false;
            this.bm_text.bitmapData = null;
            this.tf_link.text = "";
      }
      this.bm_roleHead.load(url);
      TipManager.unBind(this);
   }
   
   private function clickHd(event:Event) : void
   {
      if(this._data[Enum_HuaShan.NODE_ID1] == 0 || this._data[Enum_HuaShan.NODE_ID2] == 0)
      {
         return;
      }
      switch(this.state)
      {
         case 2:
            showZhufu(this._data);
            break;
         case 3:
            showChakan(this._data);
            break;
         case 4:
            showChakan(this._data);
      }
   }
   
   override public function get state() : int
   {
      return this._state;
   }
}

class Match2Node extends bubbleMathdeNodeViewerSP implements IBubbleMatchNodeViewer
{
   
   private var bm_headBG:Bitmap;
   
   private var bm_roleHead:Bitmap2;
   
   private var counter:int = 0;
   
   private var _way:int;
   
   private var _state:int;
   
   private var btnBet:Button;
   
   private var _data:Object;
   
   private var bindStr:String;
   
   private var mouseArea:Sprite;
   
   public function Match2Node()
   {
      super();
      this.mouseArea = new Sprite();
      addChild(this.mouseArea);
      this.bm_headBG = ComponentUtil.getBitmap("LastFightHead",this.mouseArea,{
         "x":-24,
         "y":-24
      },Global.kuafuzhan_Imgsdm);
      this.bm_roleHead = new Bitmap2();
      this.mouseArea.addChild(this.bm_roleHead);
      addEventListener(MouseEvent.CLICK,this.clickHd);
      buttonMode = true;
   }
   
   public function set way(value:int) : void
   {
      if(value > 0)
      {
         ComponentUtil.setPropertie(this.bm_roleHead,{
            "x":20,
            "y":-20,
            "scaleX":-1
         });
      }
      else
      {
         ComponentUtil.setPropertie(this.bm_roleHead,{
            "x":-20,
            "y":-20,
            "scaleX":1
         });
      }
   }
   
   override public function update(data:Object) : void
   {
      this._data = data as Array;
   }
   
   override public function set state(value:int) : void
   {
      var url:String = null;
      var model:Model_HuaShan = null;
      var pWinIndex:int = 0;
      var id:Number = NaN;
      var roleInfo:Array = null;
      this._state = value;
      switch(value)
      {
         case 2:
            if(this._data[Enum_HuaShan.NODE_ID1] != 0 && this._data[Enum_HuaShan.NODE_ID2] != 0)
            {
               if(!this.btnBet)
               {
                  this.btnBet = ComponentUtil.getButton(LangConfig.getWord("29342",2),"Button_XiaZhu",this,{
                     "x":-17,
                     "y":-10
                  },Global.kuafuzhan_Imgsdm);
               }
               this.btnBet.visible = true;
            }
            else if(Boolean(this.btnBet))
            {
               this.btnBet.visible = false;
            }
            this.bm_headBG.visible = this.bm_roleHead.visible = false;
            break;
         case 3:
            if(Boolean(this.btnBet))
            {
               this.btnBet.visible = false;
            }
            this.bm_headBG.visible = this.bm_roleHead.visible = true;
            break;
         case 4:
            model = Singleton.getInstance(Model_HuaShan);
            if(this._data[Enum_HuaShan.NODE_ID1] != 0 && this._data[Enum_HuaShan.NODE_ID2] != 0)
            {
               pWinIndex = int(this._data[Enum_HuaShan.NODE_WINWAY]);
            }
            else
            {
               pWinIndex = this._data[Enum_HuaShan.NODE_ID1] != 0 ? 1 : 2;
            }
            if(Boolean(this.btnBet))
            {
               this.btnBet.visible = false;
            }
            id = pWinIndex == 1 ? Number(this._data[Enum_HuaShan.NODE_ID1]) : Number(this._data[Enum_HuaShan.NODE_ID2]);
            roleInfo = HuaShanUtil.finPlayerInfoByID(id,model.curPlayerInfoArr);
            url = Const_strImg.getPlayerHead(roleInfo[Enum_HuaShan.CONT_ROLEJOB],roleInfo[Enum_HuaShan.CONT_ROLESEX],2);
            this.bm_headBG.visible = this.bm_roleHead.visible = true;
            break;
         default:
            if(Boolean(this.btnBet))
            {
               this.btnBet.visible = false;
            }
            this.bm_headBG.visible = this.bm_roleHead.visible = false;
      }
      TipManager.unBind(this.mouseArea);
      this.bm_roleHead.load(url);
   }
   
   private function clickHd(event:MouseEvent) : void
   {
      if(this._data[Enum_HuaShan.NODE_ID1] == 0 || this._data[Enum_HuaShan.NODE_ID2] == 0)
      {
         return;
      }
      if(this._state == 3 || this._state == 4)
      {
         showChakan(this._data as Array);
      }
      else if(this._state == 2)
      {
         showZhufu(this._data as Array);
      }
   }
   
   override public function get state() : int
   {
      return this._state;
   }
   
   private function bmLoadComplete(info:Object) : void
   {
      var bmd:BitmapData = info.content.bitmapData;
      var c:int = int(info.obj);
      if(c == this.counter)
      {
         this.bm_roleHead.bitmapData = bmd;
      }
   }
}
