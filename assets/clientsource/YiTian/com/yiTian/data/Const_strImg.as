package com.yiTian.data
{
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   
   public class Const_strImg
   {
      
      public static const GEM_0:String = "resource/image/iconNaN/gem_0.png";
      
      public static const GEM_1:String = "resource/image/iconNaN/gem_1.png";
      
      public static const LV_INTENSIFY1:String = "resource/image/iconNaN/lv_intensify1.png";
      
      public static const LV_INTENSIFY2:String = "resource/image/iconNaN/lv_intensify2.png";
      
      public static const LV_INTENSIFY3:String = "resource/image/iconNaN/lv_intensify3.png";
      
      public static const LV_INTENSIFY4:String = "resource/image/iconNaN/lv_intensify4.png";
      
      public static const LV_INTENSIFY5:String = "resource/image/iconNaN/lv_intensify5.png";
      
      public static const LV_INTENSIFY6:String = "resource/image/iconNaN/lv_intensify6.png";
      
      public static const BG_MERIDIAN_COMPOSE:String = "resource/image/iconNaN/bg_meridian_compose.jpg";
      
      public static const NEW_GEM_0:String = "resource/image/Iconlingshi/Ico_BSK_lock.png";
      
      public static const NEW_GEM_1:String = "resource/image/Iconlingshi/Ico_BSK.png";
      
      public function Const_strImg()
      {
         super();
      }
      
      public static function inlayStone(id:int) : String
      {
         var picId:int = int(Data_lib.item[id][Enum_lib_item.STR_ICON]);
         return "resource/image/Iconlingshi/" + String(picId) + ".png";
      }
      
      public static function getPlayerHead(job:int, sex:int, size:int = 0) : String
      {
         if(size == 6 || size == 7)
         {
            return "resource/image/icon/23" + Enum_job.getBaseJob(job) + size + sex + ".png";
         }
         return "resource/image/icon/23" + Enum_job.getBaseJob(job) + size + sex + ".jpg";
      }
      
      public static function getPlayerHead_M(job:int, sex:int, size:int = 0) : String
      {
         return "resource/image/newCreate/" + Enum_job.getBaseJob(job) + sex + ".png";
      }
      
      public static function getPlayerHead_N(job:int, sex:int, size:int = 0) : String
      {
         return "resource/image/newCreate/role_head/" + Enum_job.getBaseJob(job) + sex + ".png";
      }
      
      public static function getPlayerJop(job:int) : String
      {
         return "resource/image/newCreate/jops/" + Enum_job.getBaseJob(job) + ".png";
      }
      
      public static function getPlayerExPng(index:int) : String
      {
         return "resource/image/extralPng/" + index + ".png";
      }
      
      public static function getNpcHeadUrl(url:String) : String
      {
         return "resource/image/npc/" + url + ".png";
      }
      
      public static function getNpcHeadSWF(url:String) : String
      {
         return "resource/pic_swf/" + url + ".swf";
      }
      
      public static function getGuideNpcHeadUrl(url:String) : String
      {
         return "resource/image/guideNpcHead/" + url + ".png";
      }
      
      public static function getPetHeadUrl(url:String, size:int) : String
      {
         return "resource/image/icon/" + url + size + ".jpg";
      }
      
      public static function getBuffUrl(url:String) : String
      {
         return "resource/image/buff/" + url + ".png";
      }
      
      public static function getMemberUrl(job:int, sex:int, size:int) : String
      {
         return "resource/image/icon/23" + Enum_job.getBaseJob(job) + size + sex + ".jpg";
      }
   }
}

