package com.yiTian.view.modules.ShenMaoTanBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_ShenMaoTanBao;
   import com.yiTian.data.model.Model_ShenMaoTanBao;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class View_ShenMaoTanBao_menu extends Panel123
   {
      
      private static var _instance:View_ShenMaoTanBao_menu;
      
      private const mapPosition:Array = [[251,513],[294,414],[337,330],[337,228],[380,137]];
      
      private const mapStairsPos:Array = [[152,513],[206,414],[271,330],[306,228],[306,137]];
      
      private const beginningJumpCost:Array = [25,200,1000,2000];
      
      private const cost:int = 1;
      
      private const seekCost:int = 80;
      
      private const randomSmellTimes:uint = 2;
      
      private const smellCost:uint = 1500;
      
      private const speed:uint = 500;
      
      private const px:int = 20;
      
      private const floorOriArr:Array = [[0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6],[0,1,2,3,4,5],[0,1,2,3,4],[0,1,2,3]];
      
      private var mao:Sprite;
      
      private var seekTime:int;
      
      private var smellCount:int;
      
      private var t_floorOriArr:Array;
      
      private var smellRandomArray:Array;
      
      private var mao_animation:Array;
      
      private var prizePositionArray:Array;
      
      private var costCheckBox:Boolean = true;
      
      private var jumpCheckBox:Boolean = true;
      
      private var beginJumpCheckBox:Array = [true,true,true,true];
      
      private var checkObj:Object = {};
      
      private var checkFloorBeginningJumpObj:Array = [{},{},{},{}];
      
      private var isPlaying:Boolean;
      
      private var getBtn:Button;
      
      private var jumpBtn:Button;
      
      private var startJumpBtn:Button;
      
      private var jumpFailTxt:MyTextField;
      
      private var seekBtn:Button;
      
      private var helBtn:Button;
      
      private var curFloorTxt:MyTextField;
      
      private var jumpPercentTxt:MyTextField;
      
      private var grid:View_Grid;
      
      private var vo:Vo_item;
      
      public function View_ShenMaoTanBao_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/SMTB.swf","SMTBdm");
      }
      
      public static function get instance() : View_ShenMaoTanBao_menu
      {
         if(!_instance)
         {
            _instance = new View_ShenMaoTanBao_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var prizeArray:Array;
         var j:int;
         var len:int;
         var ii:int;
         var i:int = 0;
         var k:int = 0;
         var grid:View_Grid = null;
         var t_vo:Vo_item = null;
         var spr:Sprite = null;
         move = new Rectangle(0,0,916,30);
         this.isPlaying = false;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":916,
            "height":584
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":867,
            "height":534
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_SMTB",this,{
            "x":37,
            "y":52
         },Global.SMTBdm);
         ComponentUtil.getBitmap("Title_SMTB",this,{
            "x":378,
            "y":6
         },Global.SMTBdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":879,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.helBtn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":879 - 30,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(this.helBtn,"1.花费<font color=\'#ffff00\'>" + this.seekCost + "元宝</font>或者<font color=\'#ffff00\'>1份猫粮</font>可探宝一次。<br/>" + "2.每次探宝都有概率进入下1层，<font color=\'#ffff00\'>越高层的宝物越珍贵</font>。<br/>" + "3.领取宝物之后会结束本次寻宝。<br/>" + "4.如果选择进入下层，<font color=\'#ff0000\'>该层寻到的宝物将会消失</font>。<br/>");
         ComponentUtil.getBitmap("Back_XXD",this,{
            "x":714,
            "y":136
         },Global.SMTBdm);
         ComponentUtil.getTextField("当前层数：",this,{
            "x":742,
            "y":140,
            "color":10800044,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("下层概率：",this,{
            "x":742,
            "y":173,
            "color":10800044,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("当前宝物：",this,{
            "x":742,
            "y":222,
            "color":16759296,
            "size":12,
            "leading":0
         });
         this.getBtn = ComponentUtil.getButton("","Button_LQBW",this,{
            "x":749,
            "y":266,
            "textColor":16771436
         },Global.SMTBdm);
         this.jumpBtn = ComponentUtil.getButton("","Button_JRXC",this,{
            "x":749,
            "y":298,
            "textColor":16771436
         },Global.SMTBdm);
         this.startJumpBtn = ComponentUtil.getButton("","Button_TiaoCeng",this,{
            "x":749,
            "y":298,
            "textColor":16771436
         },Global.SMTBdm);
         this.seekBtn = ComponentUtil.getButton("","Button_TanBao",this,{
            "x":749,
            "y":266,
            "textColor":16771436
         },Global.SMTBdm);
         this.seekBtn.visible = false;
         this.getBtn.visible = false;
         this.jumpBtn.visible = false;
         this.startJumpBtn.visible = false;
         this.seekBtn.callBack = this.seek;
         this.getBtn.callBack = this.getPrize;
         this.jumpBtn.callBack = this.jump;
         this.startJumpBtn.callBack = this.beginningJump;
         this.jumpFailTxt = ComponentUtil.getTextField("跳入下层失败......",this,{
            "x":789,
            "y":302,
            "color":16759296,
            "size":12,
            "leading":0,
            "autoSize":"center"
         });
         this.curFloorTxt = ComponentUtil.getTextField("",this,{
            "x":807,
            "y":141,
            "color":16759296,
            "size":12,
            "leading":0
         });
         this.jumpPercentTxt = ComponentUtil.getTextField("",this,{
            "x":807,
            "y":173,
            "color":65292,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over();
         this.grid.set_tf_count();
         this.grid.x = 811;
         this.grid.y = 214;
         addChild(this.grid);
         this.vo = new Vo_item();
         ComponentUtil.getBitmap("TiZi",this,{
            "x":0 + 160,
            "y":296 + 137
         },Global.SMTBdm);
         ComponentUtil.getBitmap("TiZi",this,{
            "x":55 + 160,
            "y":210 + 137
         },Global.SMTBdm);
         ComponentUtil.getBitmap("TiZi",this,{
            "x":120 + 160,
            "y":110 + 137
         },Global.SMTBdm);
         ComponentUtil.getBitmap("TiZi",this,{
            "x":157 + 160,
            "y":18 + 137
         },Global.SMTBdm);
         this.prizePositionArray = [];
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":251,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":294,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":337,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":380,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":423,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":466,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":509,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":552,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":595,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":638,
            "y":513
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":294,
            "y":414
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":337,
            "y":414
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":380,
            "y":414
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":423,
            "y":414
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":466,
            "y":414
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":509,
            "y":414
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":552,
            "y":414
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":337,
            "y":330
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":380,
            "y":330
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":423,
            "y":330
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":466,
            "y":330
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":509,
            "y":330
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":552,
            "y":330
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":337,
            "y":228
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":380,
            "y":228
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":423,
            "y":228
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":466,
            "y":228
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":509,
            "y":228
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":380,
            "y":137
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":423,
            "y":137
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":466,
            "y":137
         },Global.SMTBdm));
         this.prizePositionArray.push(ComponentUtil.getBitmap("Grid_SMTB",this,{
            "x":509,
            "y":137
         },Global.SMTBdm));
         prizeArray = [];
         j = 1;
         while(j < 6)
         {
            k = 3;
            while(k < Data_lib.ShenMaoTanBao[j].length)
            {
               prizeArray = prizeArray.concat(Data_lib.ShenMaoTanBao[j][k]);
               k++;
            }
            j++;
         }
         len = int(prizeArray.length);
         i = 0;
         while(i < len)
         {
            grid = new View_Grid();
            grid.set_bmp_over(true,null);
            grid.set_tf_count();
            t_vo = new Vo_item();
            t_vo.id = prizeArray[i].split("_")[0];
            t_vo.count = prizeArray[i].split("_")[1];
            t_vo.Init_lib();
            t_vo.bgIndex = 0;
            grid.vo = t_vo;
            grid.x = this.prizePositionArray[i].x + 3;
            grid.y = this.prizePositionArray[i].y - 17;
            addChild(grid);
            switch(t_vo.color)
            {
               case 2:
                  grid.filters = [new GlowFilter(65280)];
                  break;
               case 3:
                  grid.filters = [new GlowFilter(26367)];
                  break;
               case 4:
                  grid.filters = [new GlowFilter(6684876)];
                  break;
               case 5:
                  grid.filters = [new GlowFilter(16750848)];
            }
            i++;
         }
         this.mao = new Sprite();
         this.addChild(this.mao);
         this.mao_animation = [];
         ii = 0;
         while(ii < 4)
         {
            spr = new Sprite();
            this.mao.addChild(spr);
            EffectManager.addEffect(String(35242 + ii),spr,1000,0,0,true);
            this.mao_animation.push(spr);
            ii++;
         }
         this.mao_animation[0].visible = false;
         this.mao_animation[1].visible = false;
         this.mao_animation[2].visible = false;
         this.mao_animation[3].visible = false;
         Global.control.registerCallBack(Enum_ShenMaoTanBao.INIT,this.onInit);
         Global.control.registerCallBack(Enum_ShenMaoTanBao.SEEK_RESULT,this.onStartSeek);
         Global.control.registerCallBack(Enum_ShenMaoTanBao.GET_RESULT,this.onGetResult);
         Global.control.registerCallBack(Enum_ShenMaoTanBao.JUMP_RESULT,this.onStartJump);
         Global.control.registerCallBack(Enum_ShenMaoTanBao.BEGINNING_JUMP,this.onBeginningJump);
      }
      
      private function maoAnimation(flag:int) : void
      {
         var i:* = undefined;
         var modelId:int = flag > 4 ? 4 : flag;
         for(i in this.mao_animation)
         {
            if(i + 1 == modelId)
            {
               this.mao_animation[i].visible = true;
            }
            else
            {
               this.mao_animation[i].visible = false;
            }
         }
         if(flag == 4)
         {
            this.mao_animation[3].scaleX = -1;
         }
         else if(flag == 5)
         {
            this.mao_animation[3].scaleX = 1;
         }
      }
      
      private function jump(e:MouseEvent) : void
      {
         if(this.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("请等待动画播放完毕");
            return;
         }
         DailyActCGMessage.CG_ShenMaoTanBao_JUMP();
      }
      
      private function beginningJump(e:MouseEvent) : void
      {
         var cost:int;
         var nextFloor:int;
         var floor:int = 0;
         if(this.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("请等待动画播放完毕");
            return;
         }
         floor = int(Model_ShenMaoTanBao.potision[0]);
         cost = int(this.beginningJumpCost[floor - 1]);
         nextFloor = floor + 1;
         if(Boolean(this.beginJumpCheckBox[floor - 1]))
         {
            View_Alert.show("是否花费" + cost + "元宝由第" + nextFloor + "层开始探宝？",2,function():void
            {
               DailyActCGMessage.CG_ShenMaoTanBao_BEGINNING_JUMP();
            },function():void
            {
               beginJumpCheckBox[floor - 1] = true;
            },this.checkFloorBeginningJumpObj[floor - 1],null,310,"","","center",this.beginJumpCheckBox[floor - 1]);
            View_Alert.instance.showCheckBox = function():void
            {
               if(View_Alert.instance.data == checkFloorBeginningJumpObj[floor - 1])
               {
                  beginJumpCheckBox[floor - 1] = !beginJumpCheckBox[floor - 1];
               }
            };
            return;
         }
         DailyActCGMessage.CG_ShenMaoTanBao_BEGINNING_JUMP();
      }
      
      private function seek(e:MouseEvent) : void
      {
         if(this.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("请等待动画播放完毕");
            return;
         }
         if(CommandManager.get_bag_count(45002) < this.cost)
         {
            if(this.costCheckBox)
            {
               View_Alert.show("<font color=\'#ff9900\'>猫粮</font>不足，是否花费<font color=\'#ff9900\'>" + this.seekCost + "元宝</font>探宝？",2,function():void
               {
                  DailyActCGMessage.CG_ShenMaoTanBao_SEEK();
               },function():void
               {
                  costCheckBox = true;
               },this.checkObj,null,310,"","","left",this.costCheckBox);
               View_Alert.instance.showCheckBox = function():void
               {
                  if(View_Alert.instance.data == checkObj)
                  {
                     costCheckBox = !costCheckBox;
                  }
               };
               return;
            }
         }
         DailyActCGMessage.CG_ShenMaoTanBao_SEEK();
      }
      
      private function getPrize(e:MouseEvent) : void
      {
         if(this.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("请等待动画播放完毕");
            return;
         }
         if(this.jumpBtn.visible)
         {
            if(this.jumpCheckBox)
            {
               View_Alert.show("<font color=\'#ff9900\'>领取宝物</font>之后就不能<font color=\'#ff9900\'>进入下层</font>，确定领取？",2,function():void
               {
                  DailyActCGMessage.CG_ShenMaoTanBao_GET();
               },function():void
               {
                  jumpCheckBox = true;
               },this.checkObj,null,310,"","","left",this.jumpCheckBox);
               View_Alert.instance.showCheckBox = function():void
               {
                  if(View_Alert.instance.data == checkObj)
                  {
                     jumpCheckBox = !jumpCheckBox;
                  }
               };
            }
            else
            {
               DailyActCGMessage.CG_ShenMaoTanBao_GET();
            }
         }
         else
         {
            DailyActCGMessage.CG_ShenMaoTanBao_GET();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            DailyActCGMessage.CG_ShenMaoTanBao_OPEN();
         }
      }
      
      private function onInit(e:*) : void
      {
         if(this.isPlaying)
         {
            return;
         }
         this.setPosition();
         this.setButton();
         this.changeGrid();
      }
      
      private function setButton() : void
      {
         var floor:int = 0;
         var potision:int = 0;
         floor = int(Model_ShenMaoTanBao.potision[0]);
         potision = int(Model_ShenMaoTanBao.potision[1]);
         if(Model_ShenMaoTanBao.btnStatus[0] == 1)
         {
            this.getBtn.visible = true;
            this.seekBtn.visible = false;
            if(Model_ShenMaoTanBao.btnStatus[1] == 1)
            {
               this.jumpBtn.visible = true;
            }
            else
            {
               this.jumpBtn.visible = false;
            }
            this.startJumpBtn.visible = false;
         }
         else
         {
            this.getBtn.visible = false;
            this.jumpBtn.visible = false;
            this.seekBtn.visible = true;
            if(potision == 0 && floor < 5)
            {
               this.startJumpBtn.visible = true;
            }
            else
            {
               this.startJumpBtn.visible = false;
            }
         }
         if(!this.jumpBtn.visible && this.getBtn.visible && floor < 5)
         {
            this.jumpFailTxt.visible = true;
         }
         else
         {
            this.jumpFailTxt.visible = false;
         }
         this.curFloorTxt.text = floor + "层";
         this.jumpPercentTxt.text = String(Data_lib.ShenMaoTanBao[floor][0]) + "%";
      }
      
      private function changeGrid() : void
      {
         var arr:Array = null;
         if(Model_ShenMaoTanBao.potision[1] == 0)
         {
            this.grid.vo = null;
         }
         else
         {
            arr = Data_lib.ShenMaoTanBao[Model_ShenMaoTanBao.potision[0]][Model_ShenMaoTanBao.potision[1] + 2].split("_");
            this.vo.id = arr[0];
            this.vo.count = arr[1];
            this.vo.Init_lib();
            this.grid.vo = this.vo;
         }
      }
      
      private function setPosition() : void
      {
         var potision:int = 0;
         var floor:int = int(Model_ShenMaoTanBao.potision[0]);
         potision = int(Model_ShenMaoTanBao.potision[1]);
         this.mao.y = this.mapPosition[floor - 1][1];
         if(potision == 0)
         {
            this.mao.x = this.mapStairsPos[floor - 1][0] + this.px;
         }
         else
         {
            this.mao.x = this.mapPosition[floor - 1][0] + 43 * (potision - 1) + this.px;
         }
         this.maoAnimation(2);
      }
      
      private function onStartSeek(e:*) : void
      {
         var id:int = 0;
         var t_pos:int = 0;
         this.isPlaying = true;
         this.grid.vo = null;
         var targetFloor:int = int(Model_ShenMaoTanBao.potision[0]);
         var targetPos:int = int(Model_ShenMaoTanBao.potision[1]);
         this.smellRandomArray = [];
         this.smellCount = Math.floor(Math.random() * this.randomSmellTimes) + 1;
         this.smellCount = Math.max(1,this.smellCount);
         this.smellCount = Math.min(Data_lib.ShenMaoTanBao[targetFloor].length - 3,this.smellCount);
         this.t_floorOriArr = this.ccc(this.floorOriArr);
         this.smellRandomArray.unshift(this.mapPosition[targetFloor - 1][0] + 43 * (targetPos - 1) + this.px);
         this.t_floorOriArr[targetFloor - 1].splice(targetPos - 1,1);
         var i:int = 0;
         while(i < this.smellCount - 1)
         {
            id = Math.floor(Math.random() * this.t_floorOriArr[targetFloor - 1].length);
            t_pos = int(this.t_floorOriArr[targetFloor - 1].splice(id,1)[0]);
            this.smellRandomArray.unshift(this.mapPosition[targetFloor - 1][0] + 43 * t_pos + this.px);
            i++;
         }
         this.toSeek();
      }
      
      private function toSeek() : void
      {
         var targetPos:int = this.smellRandomArray.shift();
         this.maoAnimation(this.checkDirection(targetPos));
         this.seekTime = Math.abs(targetPos - this.mao.x) / this.getRandomSpeed(this.speed) * 1000;
         Tween.curTo(this.mao,this.seekTime,{"x":targetPos},this.smell);
      }
      
      private function smell() : void
      {
         --this.smellCount;
         this.maoAnimation(1);
         setTimeout(function():void
         {
            if(smellCount > 0)
            {
               toSeek();
            }
            else
            {
               onMovieEnd();
            }
         },Math.max(Math.floor(Math.random() * this.smellCost) + 1,1000));
      }
      
      private function onMovieEnd() : void
      {
         this.setPosition();
         this.setButton();
         this.changeGrid();
         this.isPlaying = false;
      }
      
      private function onGetResult(e:*) : void
      {
         ComboTweenStep.toBag(this.grid);
         this.changeGrid();
         this.setButton();
         this.setPosition();
      }
      
      private function onStartJump(e:*) : void
      {
         this.isPlaying = true;
         this.grid.vo = null;
         this.maoAnimation(this.checkDirection(this.mapStairsPos[Model_ShenMaoTanBao.potision[0] - 2][0] + this.px));
         this.seekTime = Math.abs(this.mapStairsPos[Model_ShenMaoTanBao.potision[0] - 2][0] + this.px - this.mao.x) / this.getRandomSpeed(this.speed) * 1000;
         Tween.curTo(this.mao,this.seekTime,{"x":this.mapStairsPos[Model_ShenMaoTanBao.potision[0] - 2][0] + this.px},function():void
         {
            maoAnimation(3);
            seekTime = Math.abs(mapPosition[Model_ShenMaoTanBao.potision[0] - 1][1] - mao.y) / 100 * 1000;
            Tween.curTo(mao,seekTime,{"y":mapPosition[Model_ShenMaoTanBao.potision[0] - 1][1]},function():void
            {
               onStartSeek(null);
            });
         });
      }
      
      private function onBeginningJump(e:*) : void
      {
         this.isPlaying = true;
         this.maoAnimation(this.checkDirection(this.mapStairsPos[Model_ShenMaoTanBao.potision[0] - 2][0] + this.px));
         this.seekTime = Math.abs(this.mapStairsPos[Model_ShenMaoTanBao.potision[0] - 2][0] + this.px - this.mao.x) / this.getRandomSpeed(this.speed) * 1000;
         Tween.curTo(this.mao,this.seekTime,{"x":this.mapStairsPos[Model_ShenMaoTanBao.potision[0] - 2][0] + this.px},function():void
         {
            maoAnimation(3);
            seekTime = Math.abs(mapPosition[Model_ShenMaoTanBao.potision[0] - 1][1] - mao.y) / 100 * 1000;
            Tween.curTo(mao,seekTime,{"y":mapPosition[Model_ShenMaoTanBao.potision[0] - 1][1]},function():void
            {
               setButton();
               var floor:int = int(Model_ShenMaoTanBao.potision[0]);
               var potision:int = int(Model_ShenMaoTanBao.potision[1]);
               mao.y = mapPosition[floor - 1][1];
               mao.x = mapStairsPos[floor - 2][0] + px;
               maoAnimation(2);
               isPlaying = false;
            });
         });
      }
      
      private function checkDirection(targetPos:int) : int
      {
         return targetPos - this.mao.x >= 0 ? 5 : 4;
      }
      
      private function ccc(arr:Array) : Array
      {
         var i:* = undefined;
         var t:Array = arr.concat();
         for(i in arr)
         {
            if(arr[i] is Array)
            {
               t[i] = this.ccc(arr[i]);
            }
         }
         return t;
      }
      
      private function getRandomSpeed(value:uint) : uint
      {
         return Math.max(Math.floor(Math.random() * value) + 1,100);
      }
   }
}

