package com.yiTian.view.modules.blueDiamondND
{
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_BlueDiamondND_Play;
   import com.yiTian.data.vo.Vo_Blue_Goods;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BlueDiamondCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.activityGuide.Enum_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
   import com.yiTian.view.modules.blueDiamondND.xiaofeiCJ.Model_xiaoFeiCJ;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class ViewBlueDiamondNDPanel extends Panel
   {
      
      private static var REALWIDTH:int = 295;
      
      private static var NAME_LEN:int = 10;
      
      private var chontZhiButton:Button;
      
      private var Back1:ScaleBitmap;
      
      private var canvas:Canvas;
      
      private var jingYanTxt:MyTextField;
      
      private var shengYuTf:MyTextField;
      
      private var maskSpri:Shape;
      
      private var namesCon:Sprite;
      
      private var tfTime:MyTextField;
      
      private var weiZhi:int = 6;
      
      private var MaxSd:int = 10;
      
      private var MinSd:int = 0;
      
      private var addSpeed:Number;
      
      private var speed:Number = 0;
      
      private var RotationLong:Number;
      
      private var isClick:Boolean = true;
      
      private var quanShu:int;
      
      private var isRunings:Boolean;
      
      private var vecPoin:Vector.<Point> = new <Point>[new Point(165,102),new Point(214,102),new Point(261,136),new Point(289,181),new Point(289,227),new Point(261,274),new Point(214,303),new Point(165,303),new Point(121,274),new Point(92,227),new Point(92,180),new Point(119,132)];
      
      private var xiaBiao:Vector.<int> = new Vector.<int>();
      
      private var vecGrids:Vector.<View_Grid>;
      
      private var r:int = 150;
      
      private var rX:int = 200;
      
      private var rY:int = 205;
      
      private var vecSpr:Sprite = new Sprite();
      
      private var d:Array;
      
      private var vecGoods:Vector.<Vo_Blue_Goods> = new Vector.<Vo_Blue_Goods>();
      
      private var AwardsNamesTfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var popVo:Vo_BlueDiamondND_Play;
      
      private var txtPool:Array = [];
      
      private var jyMask:Shape;
      
      private var jyTip:Sprite;
      
      private const WIDTH:int = 308;
      
      private const HEIGHT:int = 19;
      
      public var min:int = 115;
      
      public var max:int = 200;
      
      public var paiXuHao:int = 0;
      
      public var shengYu:int = 0;
      
      public var isOver:String = "";
      
      public var vecPlayVo:Vector.<Vo_BlueDiamondND_Play>;
      
      public var startTime:String = "";
      
      public var endTime:String = "";
      
      private var pX:int = 395;
      
      private var pY:int = 286;
      
      private var Round:Bitmap = new Bitmap();
      
      private var ZhiZhen:Bitmap;
      
      private var GuoQing_ProgressBG:Bitmap = new Bitmap();
      
      private var GuoQing_Progress:Bitmap = new Bitmap();
      
      private var isFirstOpen:Boolean = true;
      
      private var txtName:MyTextField;
      
      private var Bule_Chong:Button;
      
      private var txtItem:MyTextField;
      
      private var Button_GO:Button;
      
      private var zhen:Sprite = new Sprite();
      
      private var temp:Bitmap = new Bitmap();
      
      public var titleUrl:String = "Title_GuoQing";
      
      public function ViewBlueDiamondNDPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.Back1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":743,
            "height":420
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":233,
            "y":53,
            "width":480,
            "height":345
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":394,
            "y":65,
            "width":310,
            "height":215
         },Global.Img_Cdm);
         this.canvas = new Canvas(306,211);
         this.canvas.x = 396;
         this.canvas.y = 67;
         addChild(this.canvas);
         addChild(this.Round);
         this.zhen.transform.matrix3D = null;
         addChild(this.zhen);
         this.tfTime = ComponentUtil.getTextField("",this,{
            "x":this.pX,
            "y":325,
            "color":11904647,
            "size":12,
            "leading":0,
            "multiline":true,
            "wordWrap":true,
            "realWidth":320
         });
         this.Bule_Chong = ComponentUtil.getButton("","Bule_Chong",this,{
            "x":480,
            "y":360,
            "textColor":16184781
         },ComponentUtil.domain);
         this.Button_GO = ComponentUtil.getButton("","Button_Go",this,{
            "x":163,
            "y":179,
            "textColor":16184781
         });
         move = new Rectangle(0,0,width,30);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":709,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.maskSpri = ComponentUtil.getShape(288,200,16646144,0.5);
         addChild(this.maskSpri);
         this.namesCon = new Sprite();
         addChild(this.namesCon);
         ComponentUtil.setPropertie(this.namesCon,{
            "x":414,
            "y":75
         });
         ComponentUtil.setPropertie(this.maskSpri,{
            "x":414,
            "y":75
         });
         this.namesCon.mask = this.maskSpri;
         this.shengYuTf = ComponentUtil.getTextField("s",this,{
            "x":this.pX,
            "y":310,
            "color":16776960,
            "size":14,
            "leading":0
         });
         this.Button_GO.callBack = this.GO;
         this.Bule_Chong.callBack = this.chongZhi;
      }
      
      private function chongZhi(e:MouseEvent) : void
      {
         UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
      }
      
      private function GO(e:MouseEvent) : void
      {
         if(!this.isClick || this.shengYu <= 0)
         {
            this.isClick = true;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60047",6));
            return;
         }
         switch(this.titleUrl)
         {
            case "Title_GuoQing":
               BlueDiamondCGMessage.CG_BLUE_DIAMOND_START();
               break;
            case "Title_xiaofei":
               BlueDiamondCGMessage.CG_XFCJ_CHOUJIANG();
               break;
            case "Title_xiaofei2":
               BlueDiamondCGMessage.CG_XFCJ2_CHOUJIANG();
               break;
            case "Title_LZDZP":
               BlueDiamondCGMessage.CG_QQGAMECJ_CHOUJIANG();
               break;
            case Model_xiaoFeiCJ.XFZP:
               BlueDiamondCGMessage.CG_ZHUANPAN_PLAY();
               break;
            case Model_xiaoFeiCJ.XYZH:
               BlueDiamondCGMessage.CG_XINGYUNCHONGZHI_PLAY();
         }
      }
      
      public function start() : void
      {
         this.RotationLong = 360 * 3 + this.weiZhi * 30;
         this.addSpeed = (this.MaxSd * this.MaxSd - this.MinSd * this.MinSd) / this.RotationLong;
         this.speed = 0;
         this.zhen.rotation = 0;
         this.addEventListener(Event.ENTER_FRAME,this.Onrotation);
         this.isClick = false;
      }
      
      private function Onrotation(evt:Event) : void
      {
         var playCount:int = 0;
         var itemCount:int = 0;
         var i:int = 0;
         this.isClick = false;
         this.isRunings = true;
         if(this.speed >= this.MaxSd)
         {
            this.speed = 2 * this.MaxSd - this.speed;
            this.addSpeed = -this.addSpeed;
         }
         this.speed += this.addSpeed;
         if(this.speed > 0)
         {
            this.Button_GO.enabled = false;
            this.zhen.rotation += this.speed;
         }
         else
         {
            this.isRunings = false;
            this.zhen.rotation = this.RotationLong;
            --this.shengYu;
            if(this.shengYu <= 0)
            {
               this.shengYu = 0;
            }
            this.updateLT_names();
            this.judgeCLick();
            this.show();
            this.removeEventListener(Event.ENTER_FRAME,this.Onrotation);
            this.isClick = true;
            this.vecGrids[this.weiZhi].filters = Util.disabled;
            playCount = 10;
            itemCount = this.vecGoods[this.weiZhi].count;
            playCount = playCount > itemCount ? itemCount : playCount;
            i = 0;
            while(i < playCount)
            {
               this.s(this.vecGrids[this.weiZhi],i * 200);
               i += 1;
            }
         }
      }
      
      private function updateLT_names() : void
      {
         var lt:int = this.shengYu;
         this.shengYuTf.text = LangConfig.getWord("60050",6) + this.shengYu.toString() + LangConfig.getWord("60051",6);
         if(this.titleUrl == Model_xiaoFeiCJ.LZSTR)
         {
            Model_xiaoFeiCJ.updateQQGameType(this.shengYu);
         }
         this.popInTxt();
      }
      
      private function s(grid:View_Grid, time:uint) : void
      {
         var toIndex:int = 0;
         toIndex = int(setTimeout(function():void
         {
            ComboTweenStep.toBag(grid,0,0,function():void
            {
               clearTimeout(toIndex);
            },"bsToBag");
         },time));
      }
      
      private function getIndex(index:int) : Array
      {
         var i:int = 0;
         while(i < this.d.length)
         {
            if(this.dataDic[index][2] == this.d[i][2])
            {
               return this.d[i];
            }
            i++;
         }
         return null;
      }
      
      private function showWheelItem() : void
      {
         var grid:View_Grid = null;
         var gridType:Array = null;
         var isBangDing:String = null;
         var i:int = 0;
         var k:* = undefined;
         var px:Number = NaN;
         var py:Number = NaN;
         var vo:Vo_item = null;
         this.vecGrids = new Vector.<View_Grid>();
         if(!this.d)
         {
            this.d = [];
            for each(k in this.dataDic)
            {
               this.d.push(k);
            }
            this.d.sort(function(a:Array, b:Array):Number
            {
               if(a[2] > b[2])
               {
                  return 1;
               }
               if(a[2] < b[2])
               {
                  return -1;
               }
               return 0;
            });
         }
         addChild(this.vecSpr);
         this.vecSpr.rotation -= 30;
         i = 0;
         while(i < 12)
         {
            px = Math.sin(Math.PI * i / 6) * (this.r - 5);
            py = Math.cos(Math.PI * i / 6) * (this.r - 5);
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_over();
            grid.set_tf_count(true,true,true);
            grid.set_bmp_bg();
            grid.set_tf_count();
            grid.x = this.vecPoin[i].x;
            grid.y = this.vecPoin[i].y;
            grid.count = i;
            vo = new Vo_item();
            vo.id = this.changelStr(this.d[i][0]);
            vo.bBind = true;
            this.xiaBiao.push(this.dataDic[i + 1][2]);
            vo.count = this.vecGoods[i].count;
            vo.Init_lib();
            grid.vo = vo;
            grid.set_bmp_select();
            TipManager.unBind(grid);
            addChild(grid);
            this.vecGrids.push(grid);
            i++;
         }
      }
      
      private function changelStr(str:String) : int
      {
         var arr:Array = str.split("_");
         var vo:Vo_Blue_Goods = new Vo_Blue_Goods();
         vo.ID = arr[1];
         vo.count = arr[2];
         this.vecGoods.push(vo);
         return vo.ID;
      }
      
      public function updateOpen(vo:Vo_BlueDiamondND_Play) : void
      {
         this.weiZhi = this.paiXuHao + 1;
         var arr:Array = this.getIndex(this.weiZhi);
         this.weiZhi = arr[2] - 1;
         this.popVo = vo;
         this.start();
         this.judgeCLick();
      }
      
      private function getTf() : MyTextField
      {
         if(Boolean(this.txtPool.length))
         {
            return this.txtPool.pop();
         }
         return ComponentUtil.getTextField("",null,{
            "realWidth":REALWIDTH,
            "visible":false,
            "multiline":true,
            "wordWrap":true
         });
      }
      
      private function popInTxt() : void
      {
         var v:Vo_item;
         var len:int;
         var tf:MyTextField = null;
         var _y:int = 0;
         var i:int = 0;
         var tempT:MyTextField = null;
         var gapLen:int = 0;
         var __y:int = 0;
         var _tf:MyTextField = null;
         tf = this.getTf();
         this.namesCon.addChild(tf);
         ComponentUtil.setPropertie(tf,{"y":215});
         tf.visible = true;
         v = new Vo_item();
         v.id = this.popVo.goodsID;
         v.Init_lib();
         tf.htmlText = HtmlUtil.font(this.popVo.name,Model_shop.get_bangJob_color_arr[Enum_job.getBaseJob(this.popVo.job)]) + "   " + LangConfig.getWord("60048",6) + Enum_BroadCastTool.instance.getColorStr(v.str_name,v.color) + " *" + this.popVo.goodsCount;
         len = int(this.AwardsNamesTfVec.length);
         if(len >= NAME_LEN)
         {
            _y = this.AwardsNamesTfVec[len - 1].y;
            Tween.to(tf,300,{"y":[tf.y,_y]},function(temTf:MyTextField):void
            {
               vecPlayVo.push(popVo);
               vecPlayVo.shift();
               AwardsNamesTfVec.push(temTf);
               var tt:MyTextField = AwardsNamesTfVec.shift();
               if(Boolean(tt))
               {
                  namesCon.removeChild(tt);
                  txtPool.push(tt);
               }
            });
            i = 0;
            while(i < len)
            {
               tempT = this.AwardsNamesTfVec[i];
               if(i == 0)
               {
                  gapLen = 20;
               }
               else
               {
                  gapLen = this.AwardsNamesTfVec[i - 1].height;
               }
               Tween.to(tempT,300,{"y":[tempT.y,tempT.y - gapLen]});
               i++;
            }
         }
         else
         {
            if(len > 0)
            {
               _tf = this.AwardsNamesTfVec[len - 1];
               __y = _tf.y + _tf.height;
            }
            else
            {
               __y = 0;
            }
            Tween.to(tf,300,{"y":[tf.y,__y]},function(temTf:MyTextField):void
            {
               vecPlayVo.push(popVo);
               AwardsNamesTfVec.push(tf);
            });
         }
      }
      
      private function reset() : void
      {
         var tf:MyTextField = null;
         while(Boolean(this.AwardsNamesTfVec.length))
         {
            tf = this.AwardsNamesTfVec.pop();
            this.namesCon.removeChild(tf);
            this.txtPool.push(tf);
         }
      }
      
      public function updateNameTxt() : void
      {
         var i:int;
         var addItem:Function;
         var len:int = 0;
         this.reset();
         len = int(this.vecPlayVo.length);
         i = 0;
         if(Boolean(len))
         {
            addItem = function(_index:int):void
            {
               var tf:MyTextField;
               var _len:int;
               var _y:int;
               var v:Vo_item;
               var vo:Vo_BlueDiamondND_Play = null;
               var __ttY:int = 0;
               if(_index >= len)
               {
                  return;
               }
               if(!visible)
               {
                  return;
               }
               vo = vecPlayVo[_index];
               tf = getTf();
               ComponentUtil.setPropertie(tf,{"y":215});
               namesCon.addChild(tf);
               _len = int(AwardsNamesTfVec.length);
               if(_len > 0)
               {
                  __ttY = AwardsNamesTfVec[_len - 1].y + AwardsNamesTfVec[_len - 1].height;
               }
               else
               {
                  __ttY = 20 * _index;
               }
               _y = __ttY;
               tf.visible = true;
               v = new Vo_item();
               v.id = vo.goodsID;
               v.Init_lib();
               tf.htmlText = HtmlUtil.font(vo.name,Model_shop.get_bangJob_color_arr[Enum_job.getBaseJob(vo.job)]) + "   " + LangConfig.getWord("60048",6) + Enum_BroadCastTool.instance.getColorStr(v.str_name,v.color) + " *" + vo.goodsCount;
               AwardsNamesTfVec.push(tf);
               Tween.to(tf,300,{"y":[tf.y,_y]},function():void
               {
                  addItem(++_index);
               });
            };
            addItem(0);
         }
      }
      
      private function jingYan() : void
      {
         var w:int = 0;
         this.jyMask = new Shape();
         this.draw(this.jyMask,this.WIDTH);
         addChild(this.jyMask);
         this.jyMask.x = this.pX;
         this.jyMask.y = this.pY;
         this.GuoQing_Progress.mask = this.jyMask;
         if(this.max == 0)
         {
            this.max = 100;
         }
         this.jingYanTxt.text = this.min.toString() + "/" + this.max.toString();
         addChild(this.jingYanTxt);
         this.jyTip = this.getSprite(this.WIDTH,this.HEIGHT);
         this.jyTip.x = this.GuoQing_Progress.x;
         this.jyTip.y = this.GuoQing_Progress.y;
         addChild(this.jyTip);
         w = this.min > this.max ? this.WIDTH : int(this.min / this.max * this.WIDTH);
         this.jyMask.width = w;
         this.jyTip.addEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
      }
      
      protected function overHandler(e:Event) : void
      {
         var str:String = "";
         switch(this.titleUrl)
         {
            case "Title_GuoQing":
            case Model_xiaoFeiCJ.XFZP:
            case Model_xiaoFeiCJ.XYZH:
               str = LangConfig.getWord("60049",6);
               break;
            case "Title_xiaofei":
            case "Title_xiaofei2":
            default:
               str = LangConfig.getWord("60049",6).replace("充值","消费");
         }
         TipManager.bind(this.jyTip,str + this.min.toString() + "/" + this.max.toString());
      }
      
      public function show() : void
      {
         var w:int = 0;
         if(this.max == 0)
         {
            this.max = 100;
         }
         this.jingYanTxt.text = this.min.toString() + "/" + this.max.toString();
         w = this.min > this.max ? this.WIDTH : int(this.min / this.max * this.WIDTH);
         this.jyMask.width = w;
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.clear();
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      private function getSprite(w:Number, h:Number) : Sprite
      {
         var temp:Sprite = new Sprite();
         var g:Graphics = temp.graphics;
         g.beginFill(16777215,0);
         g.drawRect(0,0,w,h);
         g.endFill();
         return temp;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function get dataDic() : Dictionary
      {
         switch(this.titleUrl)
         {
            case "Title_GuoQing":
               return Data_lib.gouwu;
            case "Title_xiaofei":
               return Data_lib.XFCJ;
            case "Title_xiaofei2":
               return Data_lib.XFCJ2;
            case Model_xiaoFeiCJ.XFZP:
               return Data_lib.zhuanpan;
            case Model_xiaoFeiCJ.XYZH:
               return Data_lib.xinyunchongzhi;
            default:
               return Data_lib.qqGameChoujiang;
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         var index:int = 0;
         this.updateNameTxt();
         this.shengYuTf.htmlText = LangConfig.getWord("60050",6) + this.shengYu.toString() + LangConfig.getWord("60051",6);
         if(this.titleUrl == Model_xiaoFeiCJ.LZSTR)
         {
            Model_xiaoFeiCJ.updateQQGameType(this.shengYu);
         }
         var d:Array = this.isOver.split(",");
         var isNill:Boolean = this.isOver == "-1" ? true : false;
         var arr:Array = [];
         if(!isNill)
         {
            i = 0;
            while(i < d.length)
            {
               arr[d[i]] = 1;
               i++;
            }
         }
         i = 0;
         while(i < this.vecGrids.length)
         {
            index = int(this.dataDic[int(i) + 1][2]) - 1;
            if(Boolean(arr[i]))
            {
               this.vecGrids[index].filters = Util.disabled;
            }
            else
            {
               this.vecGrids[index].filters = [];
            }
            i++;
         }
         this.updateTime();
         this.judgeCLick();
      }
      
      private function updateTime() : void
      {
         var arr:Array = null;
         var arr2:Array = null;
         var _startTime:String = this.startTime;
         var _endTime:String = this.endTime;
         _startTime += "&";
         _endTime += "&";
         var ss:String = _startTime.slice(16,20);
         var _ss:String = _endTime.slice(16,20);
         var changeS:String = _startTime.replace(ss,"");
         var changeS2:String = _endTime.replace(_ss,"");
         var showStr:String = "";
         var temp:Array = [];
         if(this.titleUrl == Model_xiaoFeiCJ.XFSTR)
         {
            temp = Model_ActivityGuide.getStartTimeById(Enum_ActivityGuide.XIAOFEICHOUJIANG);
            arr = this.startTime.split("-");
            _startTime = arr[0];
            _endTime = arr[1];
            showStr = LangConfig.getWord("60052",6) + HtmlUtil.font("{0}至{1}","#ff0000") + "前在游戏累计消费达到上面经验条。";
            showStr = showStr.replace("{0}",temp[0]).replace("{1}",temp[1]);
         }
         else if(this.titleUrl == Model_xiaoFeiCJ.XFSTR2)
         {
            temp = Model_ActivityGuide.getStartTimeById(Enum_ActivityGuide.XIAOFEIZHUANPAN);
            arr2 = this.startTime.split("-");
            _startTime = arr2[0];
            _endTime = arr2[1];
            showStr = LangConfig.getWord("60052",6) + HtmlUtil.font("{0}至{1}","#ff0000") + "前在游戏累计消费达到上面经验条。";
            showStr = showStr.replace("{0}",temp[0]).replace("{1}",temp[1]);
         }
         else if(this.titleUrl == "Title_GuoQing")
         {
            temp = Model_ActivityGuide.getStartTimeById(Enum_ActivityGuide.CHONGZHIZHUANPAN);
            showStr = LangConfig.getWord("60052",6) + HtmlUtil.font("{0}至{1}","#ff0000") + "，玩家累计充值满足条件，即可获得1次转转。";
            showStr = showStr.replace("{0}",temp[0]).replace("{1}",temp[1]);
            showStr = showStr.replace("&至&","");
         }
         else if(this.titleUrl == Model_xiaoFeiCJ.XFZP)
         {
            temp = Model_ActivityGuide.getStartTimeById(Enum_ActivityGuide.XFZP);
            arr2 = this.startTime.split("-");
            _startTime = arr2[0];
            _endTime = arr2[1];
            showStr = LangConfig.getWord("60052",6) + HtmlUtil.font("{0}至{1}","#ff0000") + "前在游戏累计充值达到上面经验条。";
            showStr = showStr.replace("{0}",temp[0]).replace("{1}",temp[1]);
         }
         else if(this.titleUrl == Model_xiaoFeiCJ.XYZH)
         {
            temp = Model_ActivityGuide.getStartTimeById(Enum_ActivityGuide.XYZH);
            arr2 = this.startTime.split("-");
            _startTime = arr2[0];
            _endTime = arr2[1];
            showStr = LangConfig.getWord("60052",6) + HtmlUtil.font("{0}至{1}","#ff0000") + "前在游戏累计充值达到上面经验条。";
            showStr = showStr.replace("{0}",temp[0]).replace("{1}",temp[1]);
         }
         this.tfTime.htmlText = showStr;
      }
      
      private function judgeCLick() : void
      {
         if(this.shengYu > 0)
         {
            this.Button_GO.enabled = true;
         }
         else
         {
            this.Button_GO.enabled = false;
         }
      }
      
      private function getDiffUnit() : void
      {
         if(this.titleUrl == Model_xiaoFeiCJ.LZSTR)
         {
            this.GuoQing_Progress.visible = false;
            this.GuoQing_ProgressBG.visible = false;
            this.tfTime.visible = false;
            this.jingYanTxt.visible = false;
            this.shengYuTf.visible = false;
            this.Bule_Chong.visible = false;
            Model_xiaoFeiCJ.addBlueUnit(this);
         }
         else
         {
            this.tfTime.visible = true;
            this.jingYanTxt.visible = true;
            this.shengYuTf.visible = true;
            this.Bule_Chong.visible = true;
         }
      }
      
      private function onCom() : void
      {
         this.ZhiZhen = new Bitmap(this.temp.bitmapData,"auto",true);
         this.ZhiZhen.x = -67;
         this.ZhiZhen.y = -136;
         this.zhen.addChild(this.ZhiZhen);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var playCount:int = 0;
         var itemCount:int = 0;
         var i:int = 0;
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_BLUEDiamondND);
               SingleLoader.add("lang/ch/ChouJiang_Imgs.swf",function(info:Object):void
               {
                  Global.ChouJiang_Imgsdm = info.applicationDomain;
               });
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf","Round",this.Round,{
                  "x":29,
                  "y":45
               });
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf","ZhiZhen",this.temp,null,null,this.onCom);
               this.zhen.x = 142 + 67;
               this.zhen.y = 89 + 136;
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf",this.titleUrl,new Bitmap(),{
                  "x":272,
                  "y":5
               },this);
               this.GuoQing_ProgressBG.x = this.pX;
               this.GuoQing_ProgressBG.y = this.pY;
               addChild(this.GuoQing_ProgressBG);
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf","GuoQing_ProgressBG",this.GuoQing_ProgressBG);
               this.jingYanTxt = ComponentUtil.getTextField("",this,{
                  "x":this.pX,
                  "y":288.6,
                  "color":16711680,
                  "size":12,
                  "leading":0,
                  "realWidth":306,
                  "align":TextAlign.CENTER
               });
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf","GuoQing_Progress",this.GuoQing_Progress);
               addChild(this.GuoQing_Progress);
               this.GuoQing_Progress.x = this.pX + 9;
               this.GuoQing_Progress.y = this.pY + 7;
               this.showWheelItem();
               this.jingYan();
               this.getDiffUnit();
            }
         }
         else
         {
            if(this.hasEventListener(Event.ENTER_FRAME))
            {
               this.removeEventListener(Event.ENTER_FRAME,this.Onrotation);
               if(this.isRunings)
               {
                  this.zhen.rotation = this.RotationLong;
                  --this.shengYu;
                  if(this.shengYu <= 0)
                  {
                     this.shengYu = 0;
                  }
                  this.updateLT_names();
                  this.judgeCLick();
                  this.show();
                  this.removeEventListener(Event.ENTER_FRAME,this.Onrotation);
                  this.isClick = true;
                  this.vecGrids[this.weiZhi].filters = Util.disabled;
                  playCount = 10;
                  itemCount = this.vecGoods[this.weiZhi].count;
                  playCount = playCount > itemCount ? itemCount : playCount;
                  i = 0;
                  while(i < playCount)
                  {
                     this.s(this.vecGrids[this.weiZhi],i * 200);
                     i += 1;
                  }
               }
            }
            this.reset();
         }
      }
   }
}

