package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_xianShiGift extends Panel
   {
      
      private static var lqYaoqiu:String;
      
      private static var lqTime:String;
      
      private static var desStrin:String;
      
      private static var stx:int = 40;
      
      private static var sty:int = 60;
      
      private static const gridLen:int = 4;
      
      private static var isFirstOpen:Boolean = true;
      
      private static var isLoad:Boolean = false;
      
      private var back:DisplayObject;
      
      private var bmp:Bitmap;
      
      private var descripTF:MyTextField;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var xianshiBtn:MainUIBtn;
      
      private var desTF:MyTextField;
      
      private var qqT:MyTextField;
      
      private var level:int;
      
      private var timeOutArr:Array = [];
      
      public function View_xianShiGift()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var str:String;
         var i:int;
         var grid:View_Grid = null;
         super.initStaticView();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":408,
            "height":250
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":360,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Invite",[5,5,6,6],this,{
            "x":34,
            "y":50,
            "width":340,
            "height":70
         },Global.Img_Cdm);
         move = new Rectangle(0,0,380,38);
         this.bmp = new Bitmap();
         addChild(this.bmp);
         this.bmp.x = stx;
         this.bmp.y = sty;
         this.descripTF = ComponentUtil.getTextField("",this,{
            "x":61,
            "y":128,
            "color":11904647,
            "color":14742993,
            "leading":2
         });
         str = HtmlUtil.font(HtmlUtil.bold("空间朋友限时礼包"),"#f4cd31",16);
         this.qqT = ComponentUtil.getTextField("",this,{
            "x":136,
            "y":6
         });
         this.qqT.htmlText = str;
         this.qqT.visible = false;
         i = 0;
         while(i < gridLen)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_count();
            grid.x = 60 + 55 * i;
            grid.y = 175;
            addChild(grid);
            this.gridVec.push(grid);
            grid.visible = false;
            i++;
         }
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":348 + 21,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getButton(LangConfig.getWord("60350",6),"Button_Orange",this,{
            "x":285,
            "y":181,
            "callBack":function(e:MouseEvent):void
            {
               if(GameUnitManager.hero.level < level)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60376",6));
                  return;
               }
               if(Global.pf == Enum_SPStr.QQ3366)
               {
                  YelloDiaCGMessage.CG_XIANSHI_GET_3366();
                  return;
               }
               if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
               {
                  YelloDiaCGMessage.CG_QQZONE_GET_GIFT();
               }
               YelloDiaCGMessage.CG_XIANSHI_GET();
            }
         },Global.Img_Cdm);
      }
      
      private function initUI() : void
      {
         var url:String;
         if(Boolean(this.xianshiBtn))
         {
            return;
         }
         url = Global.pf == Enum_SPStr.QQ3366 ? "resource/image/Diamond/xianshiGift.png" : "resource/image/Diamond/qqDating.png";
         this.xianshiBtn = new MainUIBtn(url);
         this.xianshiBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            showPane();
         });
         desStrin = Global.pf == Enum_SPStr.QQ3366 ? "通过3366登录游戏即可获得限时奖励" : LangConfig.getWord("60375",6);
         this.desTF = ComponentUtil.getTextField(desStrin,this,{
            "x":128,
            "y":85,
            "color":14662240,
            "leading":2
         });
      }
      
      private function showPane() : void
      {
         this.visible = true;
      }
      
      public function showBtn(btn:DisplayObject) : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(btn))
         {
            return;
         }
         UIManager.mainUiBtnContainer.addBTN(btn);
      }
      
      public function removeBtn(btn:DisplayObject) : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(btn))
         {
            UIManager.mainUiBtnContainer.removeBTN(btn);
         }
      }
      
      public function setData(leastLvl:int, startTime:String, endTime:String, dataArr:Array) : void
      {
         var i:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var grid:View_Grid = null;
         lqYaoqiu = LangConfig.getWord("60373",6);
         lqTime = LangConfig.getWord("60374",6);
         this.level = leastLvl;
         i = 0;
         while(i < dataArr.length)
         {
            voI = new Vo_item();
            voE = new Vo_equip();
            grid = this.gridVec[i];
            grid.visible = true;
            if(dataArr[i][0] == 1)
            {
               voI.id = dataArr[i][1];
               voI.count = dataArr[i][2];
               voI.Init_lib();
               grid.vo = voI;
            }
            else if(dataArr[i][0] == 2)
            {
               voE.id = dataArr[i][1];
               voE.count = dataArr[i][2];
               voE.Init_lib();
               grid.vo = voE;
            }
            i++;
         }
         var str1:String = lqYaoqiu + leastLvl + LangConfig.getWord("60377",6) + "\n";
         var str2:String = lqTime + startTime + "-" + endTime;
         this.descripTF.text = str1 + str2;
         if(Global.pf == "qqgame" || Global.pf == Enum_SPStr.QQ3366)
         {
            this.initUI();
            this.showBtn(this.xianshiBtn);
         }
      }
      
      private function updateQzone() : void
      {
         var _data:Array = null;
         var i:int = 0;
         var gd:View_Grid = null;
         var _type:int = 0;
         var vi:Vo_item = null;
         var ve:Vo_equip = null;
         _data = Model_txAction.QZoneArr;
         if(!_data || !_data.length)
         {
            return;
         }
         var _len:int = int(_data.length);
         i = 0;
         while(i < _len)
         {
            gd = this.gridVec[i];
            gd.visible = true;
            _type = int(_data[i][0]);
            if(_type == 1)
            {
               vi = new Vo_item();
               vi.id = _data[i][1];
               vi.count = _data[i][2];
               vi.Init_lib();
               gd.vo = vi;
            }
            else if(_type == 2)
            {
               ve = new Vo_equip();
               ve.id = _data[i][1];
               ve.count = _data[i][2];
               ve.Init_lib();
               gd.vo = ve;
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var ss1:String = null;
         var ss2:String = null;
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               if(Global.pf != Enum_SPStr.QQ3366)
               {
                  if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
                  {
                     if(!this.desTF)
                     {
                        this.desTF = ComponentUtil.getTextField("",this,{
                           "x":128,
                           "y":85,
                           "color":14662240,
                           "leading":2
                        });
                     }
                     this.desTF.text = "通过朋友网或QQ空间登陆的玩家";
                     this.level = Model_txAction.leastLvl;
                     ss1 = LangConfig.getWord("60373",6) + this.level + LangConfig.getWord("60377",6) + "\n";
                     ss2 = LangConfig.getWord("60374",6) + Model_txAction.startTime + "-" + Model_txAction.endTime;
                     this.descripTF.text = ss1 + ss2;
                     this.qqT.visible = true;
                     this.bmp = Utils.getLoadBitmap("resource/image/shouchong/QQ_Zone.png",this.bmp,null);
                     this.updateQzone();
                     return;
                  }
                  this.bmp = Utils.getLoadBitmap("resource/image/Diamond/QQ_Game.png",this.bmp,null,this.callEff);
                  if(!Global.QQGame_Imgsdm)
                  {
                     SingleLoader.add("lang/ch/QQGame_Imgs.swf",function(info:Object):void
                     {
                        Global.QQGame_Imgsdm = info.applicationDomain;
                        showB();
                     });
                  }
                  else if(!isLoad)
                  {
                     this.showB();
                  }
               }
               else
               {
                  this.bmp = Utils.getLoadBitmap("resource/image/Diamond/leiji3366.png",this.bmp,null,this.callEff);
                  if(!Global.XSGIFT3366_Imgsdm)
                  {
                     SingleLoader.add("lang/ch/3366_Imgs.swf",function(info:Object):void
                     {
                        Global.XSGIFT3366_Imgsdm = info.applicationDomain;
                        showB();
                     });
                  }
                  else if(!isLoad)
                  {
                     this.showB();
                  }
               }
            }
            else
            {
               this.callEff();
            }
         }
      }
      
      private function showB() : void
      {
         isLoad = true;
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            ComponentUtil.getBitmap("Title_XianShi",this,{
               "x":104,
               "y":5
            },Global.XSGIFT3366_Imgsdm);
         }
         else
         {
            ComponentUtil.getBitmap("Title_XianShiAward",this,{
               "x":94,
               "y":5
            },Global.QQGame_Imgsdm);
         }
      }
      
      public function callEff() : void
      {
         if(!visible)
         {
            if(Boolean(this.timeOutArr.length))
            {
               clearTimeout(this.timeOutArr.shift());
            }
            return;
         }
         this.timeOutArr.push(setTimeout(this._eff,2000));
      }
      
      public function _eff() : void
      {
         Tween.to(this.bmp,500,{
            "x":[stx + this.bmp.width / 2 - 15,stx],
            "y":[sty + this.bmp.height / 2,sty],
            "scaleX":[0,1],
            "scaleY":[0,1]
         },function():void
         {
            clearTimeout(timeOutArr.shift());
            callEff();
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function getData() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            grid = this.gridVec[i];
            if(grid.visible)
            {
               Tween.gridToBagBezierFuncDef(grid);
            }
            i++;
         }
         this.visible = false;
         this.removeBtn(this.xianshiBtn);
      }
   }
}

