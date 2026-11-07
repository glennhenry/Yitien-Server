package com.yiTian.view.modules.jiaoyi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_trans;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JiaoYiCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_trans_send_panel extends Panel
   {
      
      private var Button_FaQi:Button;
      
      private var Button_Friend:Button;
      
      private var WoFangJinYuan_text:MyTextField;
      
      private var WoFangYinYuan_text:MyTextField;
      
      private var JiaoYiRenName_text:MyTextField;
      
      private var JiaoYiName_text:MyTextField;
      
      public var grids_arr:Array = [];
      
      private var grid:View_Grid;
      
      private var isFirstOpen:Boolean = true;
      
      private var trans_target:String;
      
      private var JY_str:String;
      
      private var YY_str:String;
      
      public function View_trans_send_panel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":328,
            "height":440
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":280,
            "height":390
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":97,
            "y":50,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":97,
            "y":78,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":114,
            "width":260,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":69,
            "y":250,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":194,
            "y":250,
            "width":90,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":35,
            "y":116,
            "width":258,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("YinLiang",this,{
            "x":169,
            "y":252
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("YuanBao",this,{
            "x":45,
            "y":252
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60142",6),this,{
            "x":40,
            "y":50,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60143",6),this,{
            "x":40,
            "y":80,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60146",6) + "\n" + LangConfig.getWord("60147",6),this,{
            "x":46,
            "y":380,
            "color":11904647,
            "size":12,
            "leading":5
         });
         ComponentUtil.getTextField(LangConfig.getWord("60144",6),this,{
            "x":130,
            "y":119,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,back.width,33);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":294,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_FaQi = ComponentUtil.getButton(LangConfig.getWord("70",0),"Button_Four",this,{
            "x":134,
            "y":330,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Friend = ComponentUtil.getButton(LangConfig.getWord("71",0),"Button_Two",this,{
            "x":237,
            "y":77,
            "textColor":16184781
         },Global.Img_Cdm);
         this.WoFangJinYuan_text = ComponentUtil.getTextField(LangConfig.getWord("72",0),this,{
            "x":75,
            "y":253,
            "realWidth":87,
            "color":14013822
         });
         this.WoFangYinYuan_text = ComponentUtil.getTextField(LangConfig.getWord("73",0),this,{
            "x":198,
            "y":253,
            "realWidth":87,
            "color":14013822
         });
         this.WoFangJinYuan_text.name = LangConfig.getWord("74",0);
         this.WoFangYinYuan_text.name = LangConfig.getWord("75",0);
         this.JiaoYiRenName_text = ComponentUtil.getTextField(LangConfig.getWord("64",0),this,{
            "x":103,
            "y":80,
            "realWidth":115,
            "color":14013822
         });
         this.JiaoYiName_text = ComponentUtil.getTextField(LangConfig.getWord("76",0),this,{
            "x":103,
            "y":53,
            "realWidth":115,
            "color":14013822
         });
         this.WoFangJinYuan_text.type = TextFieldType.INPUT;
         this.WoFangYinYuan_text.type = TextFieldType.INPUT;
         this.JiaoYiRenName_text.type = TextFieldType.INPUT;
         this.JiaoYiName_text.type = TextFieldType.INPUT;
         this.JiaoYiRenName_text.maxChars = 8;
         this.JiaoYiName_text.maxChars = 8;
         this.WoFangJinYuan_text.maxChars = 10;
         this.WoFangYinYuan_text.maxChars = 10;
         this.WoFangJinYuan_text.restrict = ".0-9";
         this.WoFangYinYuan_text.restrict = ".0-9";
         this.JiaoYiRenName_text.addEventListener(FocusEvent.FOCUS_IN,this.mHandle);
         this.JiaoYiName_text.addEventListener(FocusEvent.FOCUS_IN,this.nHandle);
         this.WoFangJinYuan_text.addEventListener(FocusEvent.FOCUS_IN,this.jHandle);
         this.WoFangYinYuan_text.addEventListener(FocusEvent.FOCUS_IN,this.yHandle);
         this.JiaoYiRenName_text.addEventListener(FocusEvent.FOCUS_OUT,this.m_outHandle);
         this.JiaoYiName_text.addEventListener(FocusEvent.FOCUS_OUT,this.n_outHandle);
         this.WoFangJinYuan_text.addEventListener(FocusEvent.FOCUS_OUT,this.j_outHandle);
         this.WoFangYinYuan_text.addEventListener(FocusEvent.FOCUS_OUT,this.y_outHandle);
         this.WoFangJinYuan_text.addEventListener(Event.CHANGE,this.changedHandle);
         this.WoFangYinYuan_text.addEventListener(Event.CHANGE,this.changedHandle);
         this.Button_FaQi.addEventListener(MouseEvent.CLICK,this.transHandle);
         this.Button_Friend.addEventListener(MouseEvent.CLICK,this.FriHandle);
         i = 0;
         while(i < 5)
         {
            this.grid = new View_Grid();
            this.grid.x = 50 + i * 49;
            this.grid.y = 176;
            this.grid.set_bmp_bg();
            this.grid.set_bmp_over();
            this.grid.set_bmp_select();
            this.grid.set_tf_count();
            this.grid.isAutoLoad = false;
            this.grid.index = i + 1;
            this.grid.type = Enum_type_grid.JIAOYI;
            this.grids_arr[i] = this.grid;
            this.grid.doubleClickEnabled = true;
            if(i < 5)
            {
               this.grid.addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
               this.grid.addEventListener(MouseEvent.MOUSE_UP,this.on_Up);
               this.grid.addEventListener(MouseEvent.DOUBLE_CLICK,this.back_to_bag_handle);
            }
            addChild(this.grid);
            i++;
         }
      }
      
      public function setName(str:String) : void
      {
         str = Model_heFu.repNameByHero(str);
         this.JiaoYiRenName_text.text = str;
      }
      
      public function add_JY_goods(_grid:View_Grid) : void
      {
         var temp:Vo_valuable = null;
         var tem_num:int = this.get_empty_grid(5);
         if(Boolean(_grid) && Boolean(_grid.vo))
         {
            if(_grid.vo is Vo_equip && (_grid.vo as Vo_equip).type == 12)
            {
               UIManager.centerBroadcast.addMsg("勋章不能交易");
               return;
            }
         }
         if(tem_num == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("67",0));
         }
         else
         {
            if(_grid.vo is Vo_valuable)
            {
               temp = _grid.vo as Vo_valuable;
            }
            if(temp.bBind)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("68",0));
               return;
            }
            if(_grid.vo.count > 1)
            {
               UIManager.trans_num.visible = true;
               UIManager.trans_num.update(_grid);
               return;
            }
            this.grids_arr[tem_num].vo = _grid.vo;
            UIManager.bagPanel.set_mask(_grid.vo.gridId,true);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         super.visible = value;
         if(!value)
         {
            this.reset_data_handle();
            Model_trans.open_trans_panel();
            this.trans_target = "";
            this.JY_str = "";
            this.YY_str = "";
            this.JiaoYiRenName_text.removeEventListener(FocusEvent.FOCUS_OUT,this.m_outHandle);
            this.JiaoYiName_text.removeEventListener(FocusEvent.FOCUS_OUT,this.n_outHandle);
            this.WoFangJinYuan_text.removeEventListener(FocusEvent.FOCUS_OUT,this.j_outHandle);
            this.WoFangYinYuan_text.removeEventListener(FocusEvent.FOCUS_OUT,this.y_outHandle);
         }
         else
         {
            if(!UIManager.bagPanel.visible)
            {
               UIManager.bagPanel.visible = true;
            }
            UIManager.bagPanel.resetPosition();
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/JiaoYi_Imgs.swf","Title_JiaoYi",new Bitmap(),{
                  "x":84,
                  "y":5
               },this);
            }
         }
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this.grids_arr.length)
         {
            this.grids_arr[i].isAutoLoad = true;
            this.grids_arr[i].beginLoad();
            i++;
         }
      }
      
      private function reset_data_handle() : void
      {
         var tem_grid:View_Grid = null;
         var i:int = 0;
         while(i < this.grids_arr.length)
         {
            tem_grid = this.grids_arr[i];
            if(Boolean(tem_grid.vo))
            {
               UIManager.bagPanel.set_mask(tem_grid.vo.gridId,false);
               tem_grid.vo = null;
            }
            i++;
         }
         this.JiaoYiRenName_text.text = LangConfig.getWord("64",0);
         this.JiaoYiName_text.text = LangConfig.getWord("76",0);
         this.WoFangJinYuan_text.text = LangConfig.getWord("72",0);
         this.WoFangYinYuan_text.text = LangConfig.getWord("73",0);
      }
      
      private function back_to_bag_handle(e:MouseEvent) : void
      {
         var tem_grid:View_Grid = e.target as View_Grid;
         if(Boolean(tem_grid.vo))
         {
            UIManager.bagPanel.set_mask(tem_grid.vo.gridId,false);
            tem_grid.vo = null;
         }
      }
      
      public function update_num(_vo:Vo_grid, _count:int, _index:int = -1) : void
      {
         var tem_num:int = 0;
         if(_index != -1)
         {
            UIManager.bagPanel.set_mask(this.grids_arr[_index - 1].vo.gridId,false);
            this.grids_arr[_index - 1].vo = _vo;
            this.grids_arr[_index - 1].count = _count;
            UIManager.bagPanel.set_mask(_vo.gridId,true);
         }
         else
         {
            tem_num = this.get_empty_grid(5);
            if(tem_num == -1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("67",0));
            }
            else
            {
               this.grids_arr[tem_num].vo = _vo;
               this.grids_arr[tem_num].count = _count;
               UIManager.bagPanel.set_mask(_vo.gridId,true);
            }
         }
      }
      
      private function get_empty_grid(max_num:int) : int
      {
         var i:int = 0;
         while(i < max_num)
         {
            if(this.grids_arr[i].vo == null)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function getGrid(disp:DisplayObject) : View_Grid
      {
         if(disp is View_Grid)
         {
            return disp as View_Grid;
         }
         return this.getGrid(disp.parent);
      }
      
      private function on_Up(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var temp:Vo_valuable = null;
         var upGrid:View_Grid = this.getGrid(e.target as DisplayObject);
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.BAG)
            {
               if(dragGrid.vo is Vo_valuable)
               {
                  temp = dragGrid.vo as Vo_valuable;
               }
               if(temp.bBind)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("68",0));
                  return;
               }
               if(Boolean(temp))
               {
                  if(temp is Vo_equip && (temp as Vo_equip).type == 12)
                  {
                     UIManager.centerBroadcast.addMsg("勋章不能交易");
                     return;
                  }
               }
               this.update_grid_vo(dragGrid,upGrid);
            }
         }
      }
      
      private function update_grid(now_grid:View_Grid, pre_grid:View_Grid = null) : void
      {
         if(Boolean(pre_grid))
         {
            if(Boolean(pre_grid.vo))
            {
               UIManager.bagPanel.set_mask(pre_grid.vo.gridId,false);
               pre_grid.vo = now_grid.vo;
            }
         }
         UIManager.bagPanel.set_mask(now_grid.vo.gridId,true);
      }
      
      private function update_grid_vo(_grid:View_Grid, _up_grid:View_Grid) : void
      {
         var temN:int = this.get_empty_grid(5);
         if(temN == -1)
         {
            if(_grid.vo.count > 1)
            {
               UIManager.trans_num.visible = true;
               UIManager.trans_num.update(_grid,_up_grid.index);
               return;
            }
            this.update_grid(_grid,_up_grid);
         }
         else
         {
            if(_grid.vo.count > 1)
            {
               UIManager.trans_num.visible = true;
               UIManager.trans_num.update(_grid);
               return;
            }
            this.grids_arr[temN].vo = _grid.vo;
            this.update_grid(_grid);
         }
      }
      
      private function m_outHandle(e:FocusEvent) : void
      {
         if(e.target.text == "")
         {
            e.target.text = LangConfig.getWord("64",0);
         }
      }
      
      private function n_outHandle(e:FocusEvent) : void
      {
      }
      
      private function j_outHandle(e:FocusEvent) : void
      {
         if(e.target.text == "")
         {
            e.target.text = LangConfig.getWord("72",0);
         }
      }
      
      private function y_outHandle(e:FocusEvent) : void
      {
         if(e.target.text == "")
         {
            e.target.text = LangConfig.getWord("73",0);
         }
      }
      
      private function FriHandle(e:MouseEvent) : void
      {
         UIManager.friendPanel.visible = !UIManager.friendPanel.visible;
      }
      
      private function transHandle(e:MouseEvent) : void
      {
         var tem_grid:View_Grid = null;
         var bag_grid_arr:Array = [];
         var num_arr:Array = [];
         var trans_grid_arr:Array = [];
         var i:int = 0;
         while(i < this.grids_arr.length)
         {
            tem_grid = this.grids_arr[i];
            if(Boolean(tem_grid.vo))
            {
               bag_grid_arr.push(tem_grid.vo.gridId);
               num_arr.push(tem_grid.count);
               trans_grid_arr.push(i + 1);
            }
            i++;
         }
         this.txt_handle();
         this.JY_str = this.JY_str.replace(/,/gi,"");
         this.YY_str = this.YY_str.replace(/,/gi,"");
         if(this.trans_target == "")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("77",0));
            return;
         }
         if(!bag_grid_arr.length && this.JY_str == "" && this.YY_str == "")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("78",0));
            return;
         }
         if(int(this.JY_str) > GameUnitManager.hero.money)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("66",0));
            return;
         }
         JiaoYiCGMessage.CG_JIAOYI(this.JiaoYiRenName_text.text,this.JiaoYiName_text.text,int(this.JY_str),int(this.YY_str),bag_grid_arr,num_arr,trans_grid_arr);
      }
      
      private function txt_handle() : void
      {
         if(this.JiaoYiRenName_text.text == LangConfig.getWord("64",0))
         {
            this.trans_target = "";
         }
         else
         {
            this.trans_target = this.JiaoYiRenName_text.text;
         }
         if(this.WoFangJinYuan_text.text == LangConfig.getWord("72",0))
         {
            this.JY_str = "";
         }
         else
         {
            this.JY_str = this.WoFangJinYuan_text.text;
         }
         if(this.WoFangYinYuan_text.text == LangConfig.getWord("73",0))
         {
            this.YY_str = "";
         }
         else
         {
            this.YY_str = this.WoFangYinYuan_text.text;
         }
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(tf.name == LangConfig.getWord("74",0))
         {
            Model_trans.txt_ch_handle(tf,GameUnitManager.hero.money);
         }
         else if(tf.name == LangConfig.getWord("75",0))
         {
            Model_trans.txt_ch_handle(tf,GameUnitManager.hero.silver);
         }
         trace("-----",tf.text);
         var tempStr:String = tf.text.replace(/,/gi,"");
         tf.text = Utils.getGapNum(tempStr);
         tf.setSelection(tf.length,tf.length);
      }
      
      private function mHandle(e:FocusEvent) : void
      {
         if(e.target.text == LangConfig.getWord("64",0))
         {
            e.target.text = "";
         }
      }
      
      private function jHandle(e:FocusEvent) : void
      {
         if(e.target.text == LangConfig.getWord("72",0))
         {
            e.target.text = "";
         }
      }
      
      private function yHandle(e:FocusEvent) : void
      {
         if(e.target.text == LangConfig.getWord("73",0))
         {
            e.target.text = "";
         }
      }
      
      private function nHandle(e:FocusEvent) : void
      {
         if(e.target.text == LangConfig.getWord("79",0))
         {
            e.target.text = "";
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 - 150;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

