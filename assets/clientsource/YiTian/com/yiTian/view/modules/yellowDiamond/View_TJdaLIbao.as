package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_TJdaLIbao extends Panel
   {
      
      private static const timeStr:String = "{0}至{1}";
      
      private static const GRID_LEN:int = 4;
      
      private var titleArr:Array = ["Txt_HuangZhuan","Txt_DaTing"];
      
      private var btnArr:Array = ["BT_LJLingQu","BT_LJLingQuBul"];
      
      private var descripArr:Array = ["在活动时间内从黄钻每日礼包推荐进入游戏可领\n取倚天黄钻推荐大礼包；每人每天只能领取一次\n哦！","在活动时间内从大厅进入游戏可领取倚天大厅推\n荐大礼包；每人每天只能领取一次哦！"];
      
      private var timeTF:MyTextField;
      
      private var point:Point = new Point(236,229);
      
      private var contn:Sprite;
      
      private var maskn:Sprite;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var dataSS:String;
      
      private var power:Number = 1;
      
      private var rato:int = 6;
      
      private var dataA:Array = [[1,46257,4],[1,46258,3],[1,46259,2],[1,46260,5]];
      
      public function View_TJdaLIbao()
      {
         super();
         bindParent = GameScene.uiLayer;
      }
      
      public function initSource() : void
      {
         super.visible = true;
         if(!Global.YTHZDaLiBaodm)
         {
            SingleLoader.add("lang/ch/YTHZDaLiBao.swf",function(info:Object):void
            {
               Global.YTHZDaLiBaodm = info.applicationDomain;
               initData();
            });
         }
      }
      
      private function initData() : void
      {
         var strTitle:String = null;
         var descripStr:String = null;
         var btnStr:String = null;
         var bmpStr:String = null;
         var titleStr:String = null;
         var i:int = 0;
         var _data:Array = null;
         var grid:View_Grid = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var vo:Vo_item = null;
         ComponentUtil.getScaleBitmap("Di_LJLingQu",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":480,
            "height":430
         },Global.YTHZDaLiBaodm);
         move = new Rectangle(0,0,480,32);
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            strTitle = this.titleArr[0];
            btnStr = this.btnArr[0];
            descripStr = this.descripArr[0];
            bmpStr = "libaohz";
            titleStr = "Txt_HuangZhuan";
         }
         else if(Global.pf == Enum_SPStr.QQGAME)
         {
            strTitle = this.titleArr[1];
            btnStr = this.btnArr[1];
            descripStr = this.descripArr[1];
            bmpStr = "libaodating";
            titleStr = "Txt_DaTing";
         }
         ComponentUtil.getTextField(descripStr,this,{
            "x":136,
            "y":135,
            "color":9319432,
            "size":12,
            "leading":5,
            "filters":[],
            "bold":true
         });
         ComponentUtil.getScaleBitmap(strTitle,[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":479,
            "height":101
         },Global.YTHZDaLiBaodm);
         ComponentUtil.getButton("",btnStr,this,{
            "x":194,
            "y":350,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               YelloDiaCGMessage.CG_TUIJIAN_LIBAO_SEND();
            }
         },Global.YTHZDaLiBaodm);
         ComponentUtil.getButton("","Button_HDClose",this,{
            "x":453,
            "y":5,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         });
         this.timeTF = ComponentUtil.getTextField(this.dataSS,this,{
            "x":136,
            "y":114,
            "color":9319432,
            "size":12,
            "leading":0,
            "filters":[],
            "bold":true
         });
         this.contn = new Sprite();
         this.contn.graphics.beginFill(0,0);
         this.contn.graphics.drawRect(0,0,187,113);
         this.contn.x = this.point.x - 300;
         this.contn.y = this.point.y;
         this.contn.graphics.endFill();
         addChild(this.contn);
         ComponentUtil.getBitmap("WuPinDi",this.contn,null,Global.YTHZDaLiBaodm);
         ComponentUtil.getBitmap(bmpStr,this,{
            "x":97,
            "y":229
         },Global.YTHZDaLiBaodm);
         ComponentUtil.getBitmap(titleStr,this,{
            "x":0,
            "y":0
         },Global.YTHZDaLiBaodm);
         i = 0;
         while(i < GRID_LEN)
         {
            _data = this.dataA[i];
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            this.contn.addChild(grid);
            type = int(_data[0]);
            id = int(_data[1]);
            count = int(_data[2]);
            if(type == 1)
            {
               vo = new Vo_item();
               vo.id = id;
               vo.Init_lib();
               vo.count = count;
            }
            grid.x = 41 + 49.5 * int(i % 2);
            grid.y = 16 + 44.95 * int(i / 2);
            grid.vo = vo;
            this.gridVec.push(grid);
            i++;
         }
         this.maskn = new Sprite();
         this.maskn.graphics.beginFill(0,0);
         this.maskn.graphics.drawRect(0,0,187,113);
         this.maskn.graphics.endFill();
         this.maskn.x = this.point.x;
         this.maskn.y = this.point.y;
         addChild(this.maskn);
         this.contn.mask = this.maskn;
         this.visible = true;
      }
      
      public function show(_data:Array, staS:String, endS:String) : void
      {
         var ss:String = timeStr.replace("{0}",staS).replace("{1}",endS);
         this.dataSS = ss;
         this.dataA = _data;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var tt:int = 0;
         if(value)
         {
            scaleX = 1;
            scaleY = 1;
            super.visible = value;
            if(Boolean(this.contn))
            {
               this.contn.x = this.point.x - 300;
            }
            Tween.to(this,200,{
               "y":[(Global.stage.stageHeight - 430) / 2 - 50,(Global.stage.stageHeight - 430) / 2],
               "alpha":[0,1]
            });
            tt = int(setTimeout(function():void
            {
               Tween.to(contn,800,{"x":[point.x - 300,point.x]},null,null,tFun);
               clearTimeout(tt);
            },300));
         }
         else
         {
            Tween.to(this,200,{
               "y":[this.y,this.y - 50],
               "alpha":[1,0]
            },this.comp);
         }
      }
      
      private function comp() : void
      {
         super.visible = false;
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.rato;
         return 1 - Math.sin(rate) / rate;
      }
      
      public function getAwards() : void
      {
         var g:View_Grid = null;
         var cnt:int = 0;
         var j:int = 0;
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            g = this.gridVec[i];
            cnt = g.count;
            j = 0;
            while(j < cnt)
            {
               ComboTweenStep.toBag(g,0,0,null,"bsToBag");
               j++;
            }
            i++;
         }
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 480) / 2;
         y = (Global.stage.stageHeight - 430) / 2;
      }
   }
}

