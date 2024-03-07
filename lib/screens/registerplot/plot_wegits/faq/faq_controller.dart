import 'package:flutter/material.dart';

import '../../../../util/image_assets.dart';


class faqcnt extends ChangeNotifier{ 

List<Map<String, String>> items = [
    {
      'id': "1",
      'name': "Schedule",
      'image': ImageAssets.ic_schedule
    },
    {
      'id': "2",
      'name': "Ask Question",
      'image':ImageAssets.ic_question
          
    },
    {
      'id': "3",
      'name': "Nutrient management",
      'image': ImageAssets.ic_report
    },
    {
      'id': "4",
      'name': "Faq",
      'image':ImageAssets.ic_faq
    },
    {
      'id': "5",
      'name': "Dairy",
      'image':ImageAssets.ic_diary
        
    },
    {
      'id': "6",
      'name': "Dsease control",
      'image':ImageAssets.ic_virus
    },
    {
      'id': "7",
      'name': "My Plot",
      'image':ImageAssets.ic_plot
    },
    {
      'id': "8",
      'name': "Observation Report ",
      'image':ImageAssets.ic_observation_report_image
    }
  ]; 

List<Map<String, String>> scheduleitem = [
    {
      'id': "1",
      'name': "Spray",
      'image': ImageAssets.ic_spray
    },
    {
      'id': "2",
      'name': "Firtilzer",
      'image':ImageAssets.ic_fertilizer
          
    },
    {
      'id': "3",
      'name': "General",
      'image':ImageAssets.ic_general
          
    },
   
   
  
  
    
    
  ]; 




} 