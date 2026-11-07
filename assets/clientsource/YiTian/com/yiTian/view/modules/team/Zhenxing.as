package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_ZhenFa;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Zhenxing extends Panel
   {
      
      private var Button_OK:Button;
      
      private var ZhenFa_Name_text:MyTextField;
      
      private var ZhenFa_Style_text:MyTextField;
      
      private var grids:Array = [];
      
      private var _grids:Array = [];
      
      private var temGrid:View_Grid;
      
      private var _grid:ZhenFaViewGrid;
      
      private var zhenFaDic:Dictionary;
      
      private var zhenFaPos:Array;
      
      private var nowGrid:View_Grid;
      
      private var _zhenFaSign:int;
      
      private var memberDataArr:Array;
      
      private var gridSlect:int = 0;
      
      private var resetZhenFa:Array = [["11","12","13","21","22","23"],["11","13","21","23","31","33"],["12","21","22","23","31","33"],["11","13","22","32","31","33"],["11","12","13","22","31","33"],["12","21","23","31","32","33"],["13","22","23","31","32","33"],["12","13","21","23","31","32"]];
      
      private const HP:int = 1;
      
      private const MP:int = 2;
      
      private const CUR:int = 3;
      
      private const MAX:int = 4;
      
      private var isFirstOpen:Boolean = true;
      
      public function Zhenxing()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         super.initStaticView();
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":338,
            "height":385
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":290,
            "height":335
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":160,
            "width":270,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60304",6) + "\n" + LangConfig.getWord("60305",6),this,{
            "x":40,
            "y":335,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60306",6),this,{
            "x":155,
            "y":46,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,back.width,35);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Two64",this,{
            "x":213,
            "y":288,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":304,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.ZhenFa_Name_text = ComponentUtil.getTextField(LangConfig.getWord("10180",1),this,{
            "x":194,
            "y":168,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.ZhenFa_Style_text = ComponentUtil.getTextField(LangConfig.getWord("10181",1),this,{
            "x":194,
            "y":187,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.ZhenFa_Style_text.realWidth = 107.65;
         this.ZhenFa_Style_text.wordWrap = true;
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.zhenfaHandle);
      }
      
      override protected function initDynamicView() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         var _i:int = 0;
         super.initDynamicView();
         i = 0;
         while(i < 10)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_bg();
            grid.set_bmp_select();
            grid.set_bmp_over();
            grid.x = 39 + (Const_png.SIZE_GRID + 16) * (i % 5);
            grid.y = 70 + (Const_png.SIZE_GRID + 7) * Math.floor(i / 5);
            grid.isAutoLoad = false;
            grid.index = i;
            addChild(grid);
            this.grids.push(grid);
            i++;
         }
         _i = 0;
         while(_i < 9)
         {
            this._grid = new ZhenFaViewGrid(false,".jpg");
            this._grid.set_bmp_select();
            this._grid.set_tf_count(true,false,true);
            this._grid.gridPostion = int(int(_i / 3) + 1 + "" + (3 - _i % 3));
            this._grid.x = 39 + (46 + 6) * (_i % 3);
            this._grid.y = 165 + (46 + 6) * Math.floor(_i / 3);
            this._grid.isAutoLoad = false;
            this._grid.index = _i;
            addChild(this._grid);
            this._grids.push(this._grid);
            _i++;
         }
      }
      
      private function onUp(e:MouseEvent) : void
      {
         var mVO:MemberVO = null;
         var dragGrid:ZhenFaViewGrid = UIManager.dragObj.grid as ZhenFaViewGrid;
         var targetGrid:ZhenFaViewGrid = e.target as ZhenFaViewGrid;
         if(UIManager.isDrag && Boolean(dragGrid))
         {
            mVO = dragGrid.vo as MemberVO;
            if(Boolean(dragGrid.type == Enum_type_grid.ZHENXING) && Boolean(mVO) && Boolean(mVO.str_icon))
            {
               dragGrid.vo = targetGrid.vo;
               targetGrid.vo = mVO;
            }
         }
      }
      
      private function zhenfaHandle(e:MouseEvent) : void
      {
         var zhenFaStr:String;
         var char1:String;
         var char2:String;
         var i:uint;
         var j:uint;
         var strArr:Array = null;
         var idArr:Array = null;
         strArr = [];
         idArr = [];
         var g:Array = this._grids.filter(function(item:ZhenFaViewGrid, index:int, arr:Array):Boolean
         {
            var mVO:* = item.vo as MemberVO;
            return Boolean(mVO) && mVO.orderId > 0 ? true : false;
         });
         g.sort(function(a:ZhenFaViewGrid, b:ZhenFaViewGrid):int
         {
            var aVO:MemberVO = a.vo as MemberVO;
            var bVO:MemberVO = b.vo as MemberVO;
            if(aVO.orderId > bVO.orderId)
            {
               return 1;
            }
            if(aVO.orderId < bVO.orderId)
            {
               return -1;
            }
            return 0;
         });
         g.forEach(function(item:ZhenFaViewGrid, index:int, arr:Array):void
         {
            var mvo:MemberVO = item.vo as MemberVO;
            strArr.push(item.gridPostion);
            if(mvo.memberId > 0)
            {
               idArr.push(mvo.memberId);
            }
         });
         zhenFaStr = "";
         char1 = "_";
         char2 = "|";
         i = 0;
         j = 0;
         while(i < idArr.length)
         {
            if(i == idArr.length - 1)
            {
               char2 = "";
            }
            else
            {
               char2 = "|";
            }
            zhenFaStr += idArr[i].toString() + char1 + strArr[j++].toString() + char1 + strArr[j++].toString() + char2;
            i++;
         }
         trace("wadrew:::",zhenFaStr);
         TeamCGMessage.CG_CHANGE_ZHENFA(int(Model_team.learnZhenFa.split("_")[this.gridSlect]),zhenFaStr);
         UIManager.zhenxing.visible = false;
      }
      
      private function selTeam(e:MouseEvent) : void
      {
         this.grids[this.gridSlect].bSelect = false;
         e.target.bSelect = true;
         this.gridSlect = e.target.index;
         var i:uint = 0;
         var j:uint = 0;
         while(i < Model_team.teamMumberInfo_data_save.length)
         {
            this.memberDataArr[i][10] = this.zhenFaPos[e.target.index][j++];
            this.memberDataArr[i][12] = this.zhenFaPos[e.target.index][j++];
            i++;
         }
         this.showZhenFa();
      }
      
      public function updata() : void
      {
         var tempV:Vo_grid = null;
         var vo:Vo_ZhenFa = null;
         var arr:Array = null;
         var a:Array = null;
         var b:Array = null;
         var j:uint = 0;
         var fooBA:ByteArray = new ByteArray();
         fooBA.writeObject(Model_team.teamMumberInfo_data_save);
         fooBA.position = 0;
         this.memberDataArr = fooBA.readObject() as Array;
         this.zhenFaPos = [];
         this.resetZhenFa = [];
         var zfArr:Array = Model_team.learnZhenFa.split("_");
         var zfVOArr:Vector.<Vo_ZhenFa> = new Vector.<Vo_ZhenFa>();
         var k:uint = 0;
         while(k < zfArr.length)
         {
            vo = new Vo_ZhenFa(int(zfArr[k]));
            arr = vo.weizhi.split(",");
            a = [];
            b = [];
            zfVOArr.push(vo);
            j = 0;
            while(j < arr.length)
            {
               a.push(int(arr[j]));
               b.push(int(arr[j]));
               j++;
            }
            this.zhenFaPos.push(a);
            this.resetZhenFa.push(b);
            k++;
         }
         this.gridSlect = zfArr.indexOf(Model_team.currentZhenFa.toString());
         k = 0;
         j = 0;
         while(k < this.memberDataArr.length)
         {
            this.zhenFaPos[this.gridSlect][j++] = this.memberDataArr[k][10];
            this.zhenFaPos[this.gridSlect][j++] = this.memberDataArr[k][12];
            k++;
         }
         var i:uint = 0;
         while(i < 10)
         {
            (this.grids[i] as DisplayObject).filters = Util.disabled;
            this.grids[i].mouseEnabled = false;
            this.grids[i].bSelect = false;
            this.grids[i].vo = null;
            if(Boolean(this.grids[i].hasEventListener(MouseEvent.CLICK)))
            {
               this.grids[i].removeEventListener(MouseEvent.CLICK,this.selTeam);
            }
            i++;
         }
         i = 0;
         while(i < Model_team.learnZhenFa.split("_").length)
         {
            if(i == this.gridSlect)
            {
               this.grids[i].bSelect = true;
            }
            tempV = new Vo_grid();
            tempV.str_icon = zfVOArr[i].img.toString();
            this.grids[i].vo = tempV;
            (this.grids[i] as DisplayObject).filters = [];
            this.grids[i].mouseEnabled = true;
            (this.grids[i] as View_Grid).addEventListener(MouseEvent.CLICK,this.selTeam);
            i++;
         }
         this.showZhenFa();
      }
      
      private function showZhenFa() : void
      {
         var memberVO:MemberVO = null;
         var memberFlat:int = 0;
         var petFlat:int = 0;
         var skip:int = 0;
         var zfId:int = 0;
         var zfVO:Vo_ZhenFa = null;
         var petData:Array = null;
         var i:uint = 0;
         while(i < this._grids.length)
         {
            (this._grids[i] as DisplayObject).filters = Util.disabled;
            this._grids[i].mouseEnabled = false;
            this._grids[i].vo = null;
            this._grids[i].index = i;
            if(Boolean(this._grids[i].hasEventListener(MouseEvent.MOUSE_DOWN)))
            {
               this._grids[i].removeEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
            }
            if(Boolean(this._grids[i].hasEventListener(MouseEvent.MOUSE_UP)))
            {
               this._grids[i].removeEventListener(MouseEvent.MOUSE_UP,this.onUp);
            }
            i++;
         }
         var j:uint = 0;
         while(j < 6)
         {
            i = 0;
            while(i < 9)
            {
               if(int(int(i / 3) + 1 + "" + (3 - i % 3)) == this.resetZhenFa[this.gridSlect][j])
               {
                  this._grids[i].mouseEnabled = true;
                  this._grids[i].addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
                  this._grids[i].addEventListener(MouseEvent.MOUSE_UP,this.onUp);
                  (this._grids[i] as DisplayObject).filters = [];
                  break;
               }
               i++;
            }
            j++;
         }
         var sn:int = 1;
         i = 0;
         while(i < this.memberDataArr.length)
         {
            skip = 0;
            j = 0;
            while(j < 9)
            {
               if(int(int(j / 3) + 1 + "" + (3 - j % 3)) == this.memberDataArr[i][10])
               {
                  memberFlat = int(j);
                  skip++;
                  if(skip == 2)
                  {
                     break;
                  }
               }
               if(int(int(j / 3) + 1 + "" + (3 - j % 3)) == this.memberDataArr[i][12])
               {
                  petFlat = int(j);
                  skip++;
                  if(skip == 2)
                  {
                     break;
                  }
               }
               j++;
            }
            (this._grids[memberFlat] as DisplayObject).filters = [];
            memberVO = new MemberVO();
            memberVO.str_icon = "23" + Enum_job.getBaseJob(this.memberDataArr[i][8]).toString() + "2" + Model_team.memberIcon[i][1].toString();
            memberVO.str_name = this.memberDataArr[i][13].toString();
            memberVO.name = this.memberDataArr[i][7];
            memberVO.level = this.memberDataArr[i][9];
            memberVO.job = this.memberDataArr[i][8];
            if(i > 0)
            {
               memberVO.hp = this.getRoleHPMP(this.memberDataArr[i][13],this.HP,this.CUR);
               memberVO.hpMax = this.getRoleHPMP(this.memberDataArr[i][13],this.HP,this.MAX);
               memberVO.mp = this.getRoleHPMP(this.memberDataArr[i][13],this.MP,this.CUR);
               memberVO.mpMax = this.getRoleHPMP(this.memberDataArr[i][13],this.MP,this.MAX);
            }
            else
            {
               memberVO.hp = GameUnitManager.hero.hp;
               memberVO.hpMax = GameUnitManager.hero.hpMax;
               memberVO.mp = GameUnitManager.hero.mp;
               memberVO.mpMax = GameUnitManager.hero.mpMax;
            }
            memberVO.memberOrPet = true;
            memberVO.orderId = sn++;
            memberVO.memberId = this.memberDataArr[i][13];
            this._grids[memberFlat].vo = memberVO;
            this._grids[memberFlat].mouseEnabled = true;
            (this._grids[petFlat] as DisplayObject).filters = [];
            memberVO = new MemberVO();
            memberVO.orderId = sn++;
            memberVO.memberOrPet = false;
            if(this.memberDataArr[i][11] > 0)
            {
               if(Global.pf == "qqgame")
               {
                  if(this.memberDataArr[i][6] == 20906)
                  {
                     this.memberDataArr[i][6] = 20907;
                  }
               }
               memberVO.str_icon = this.memberDataArr[i][6] + "_40";
               memberVO.str_name = this.memberDataArr[i][11].toString();
               petData = this.getPetHP(this.memberDataArr[i][11]);
               if(petData.length > 0)
               {
                  memberVO.name = petData[1];
                  memberVO.level = petData[2];
                  memberVO.hp = petData[3];
                  memberVO.hpMax = petData[4];
               }
            }
            else
            {
               memberVO.str_icon = null;
            }
            this._grids[petFlat].vo = memberVO;
            this._grids[petFlat].mouseEnabled = true;
            zfId = int(Model_team.learnZhenFa.split("_")[this.gridSlect]);
            zfVO = new Vo_ZhenFa(zfId);
            this.ZhenFa_Name_text.text = zfVO.level + LangConfig.getWord("10169",1) + zfVO.name;
            this.ZhenFa_Style_text.text = zfVO.miaoshu;
            i++;
         }
      }
      
      private function getPetHP(id:Number) : Array
      {
         var data:Array = [];
         var a:Array = Model_team.petInfoArr;
         var i:uint = 0;
         while(i < a.length)
         {
            if(id == a[i][0])
            {
               data = a[i];
               break;
            }
            i++;
         }
         return data;
      }
      
      private function getRoleHPMP(id:Number, type:int, curOrMax:int) : int
      {
         var i:uint = 0;
         var num:int = -1;
         var arr:Array = Model_team.HMPArr;
         i = 0;
         while(i < arr.length)
         {
            if(arr[i][0] == id)
            {
               if(type == this.HP)
               {
                  if(curOrMax == this.CUR)
                  {
                     num = int(arr[i][1]);
                     break;
                  }
                  if(curOrMax == this.MAX)
                  {
                     num = int(arr[i][2]);
                  }
                  break;
               }
               if(type == this.MP)
               {
                  if(curOrMax == this.CUR)
                  {
                     num = int(arr[i][3]);
                     break;
                  }
                  if(curOrMax == this.MAX)
                  {
                     num = int(arr[i][4]);
                  }
                  break;
               }
            }
            i++;
         }
         return num;
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < 10)
         {
            this.grids[i].isAutoLoad = true;
            this.grids[i].beginLoad();
            if(i < 9)
            {
               this._grids[i].isAutoLoad = true;
               this._grids[i].set_bmp_bg("resource/image/team/zxBg.png");
               this._grids[i].set_bmp_over(true,"resource/image/team/grid_Skill_over.png");
               this._grids[i].beginLoad();
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(this.isFirstOpen && value)
         {
            this.setGridLoad();
            this.isFirstOpen = false;
            Utils.loadTitle("lang/ch/TeamInformatImgs.swf","Title_ZhenXing",new Bitmap(),{
               "x":89,
               "y":5
            },this);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

