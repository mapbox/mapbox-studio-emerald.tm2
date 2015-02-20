// =====================================================================
// LABELS

// General notes:
// - `text-halo-rasterizer: fast;` gives a noticeable performance
//    boost to render times and is recommended for *all* halos.

// ---------------------------------------------------------------------
// Languages

// There are 5 language options in the MapBox Streets vector tiles:
// - Local/default: '[name]'
// - English: '[name_en]'
// - French: '[name_fr]'
// - Spanish: '[name_es]'
// - German: '[name_de]'
@name: '[name]';  
@name_en: '[name_en]';  

// ---------------------------------------------------------------------
// Fonts

// All fontsets should have a good fallback that covers as many glyphs
// as possible. 'Arial Unicode MS Regular' and 'Arial Unicode MS Bold' 
//are recommended as final fallbacks if you have them available. 
//They support all the characters used in the MapBox Streets vector tiles.
@fallback: 'Open Sans Regular';
@sans: 'Open Sans Regular', 'Arial Unicode MS Regular';
@sans_md: 'Open Sans Semibold', 'Arial Unicode MS Regular';
@sans_bd: 'Open Sans Bold','Arial Unicode MS Bold';
@sans_it: 'Open Sans Italic', 'Arial Unicode MS Regular';


// ---------------------------------------------------------------------
// Countries

// The country labels in MapBox Streets vector tiles are placed by hand,
// optimizing the arrangement to fit as many as possible in densely-
// labeled areas.
#country_label[zoom>=2] {
  text-name: @name_en;
  text-face-name: @sans_bd;
  text-transform: uppercase;
  text-wrap-width: 100;
  text-wrap-before: true;
  text-fill: #334;
  text-halo-fill: fadeout(#fff,80%);
  text-halo-radius: 2;
  text-halo-rasterizer: fast;
  text-line-spacing: -4;
  text-character-spacing: 0.5;
  text-size: 8;
  [zoom>=3][scalerank=1],
  [zoom>=4][scalerank=2],
  [zoom>=5][scalerank=3],
  [zoom>=6][scalerank>3] {
    text-size: 12;
  }
  [zoom>=4][scalerank=1],
  [zoom>=5][scalerank=2],
  [zoom>=6][scalerank=3],
  [zoom>=7][scalerank>3] {
    text-size: 15;
  }
}

// ---------------------------------------------------------------------
// Marine

#marine_label[zoom>=2]["mapnik::geometry_type"=1],
#marine_label[zoom>=2]["mapnik::geometry_type"=2] {
  text-name: @name;
  text-face-name: @sans_it;
  text-wrap-width: 60;
  text-wrap-before: true;
  text-fill: darken(@water, 10);
  text-halo-fill: fadeout(#fff, 75%);
  text-halo-radius: 1.5;
  text-size: 10;
  text-character-spacing: 1; 
  ["mapnik::geometry_type"=1] {
    text-placement: point;
    text-wrap-width: 30;
  }
  ["mapnik::geometry_type"=2] {
    text-placement: line;
  }
  // Oceans
  [labelrank=1] { 
    text-size: 18;
    text-wrap-width: 120;
    text-character-spacing:	4;
    text-line-spacing:	8;
  }
  [labelrank=2] { text-size: 14; }
  [labelrank=3] { text-size: 11; }
  [zoom>=5] {
    text-size: 12;
    [labelrank=1] { text-size: 22; }
    [labelrank=2] { text-size: 16; }
    [labelrank=3] {
      text-size: 14;
      text-character-spacing: 2;
     }
   }
}

// ---------------------------------------------------------------------
// Cities, towns, villages, etc

// City labels with dots for low zoom levels.
// The separate attachment keeps the size of the XML down.
#place_label::citydots[type='city'][zoom>=4][zoom<=7][localrank<=1] {
  // explicitly defining all the `ldir` values wer'e going
  // to use shaves a bit off the final project.xml size
  [ldir='N'],[ldir='S'],[ldir='E'],[ldir='W'],
  [ldir='NE'],[ldir='SE'],[ldir='SW'],[ldir='NW'] {
    shield-file: url("shield/dot.svg");
    shield-transform:scale(0.3,0.3);
    shield-unlock-image: true;
    shield-name: @name;
    shield-size: 12;
    shield-face-name: @sans;
    shield-placement: point;
    shield-fill: #333;
    shield-halo-fill: fadeout(#fff, 50%);
    shield-halo-radius: 2;
    shield-halo-rasterizer: fast;
    shield-margin:30;
    [zoom=7] { shield-size: 14; }

    [ldir='E'] { shield-text-dx: 5; }
    [ldir='W'] { shield-text-dx: -5; }
    [ldir='N'] { shield-text-dy: -5; }
    [ldir='S'] { shield-text-dy: 5; }
    [ldir='NE'] { shield-text-dx: 4; shield-text-dy: -4; }
    [ldir='SE'] { shield-text-dx: 4; shield-text-dy: 4; }
    [ldir='SW'] { shield-text-dx: -4; shield-text-dy: 4; }
    [ldir='NW'] { shield-text-dx: -4; shield-text-dy: -4; }
  }
}

#place_label[zoom>=8][localrank<=1] {
  text-name: @name;
  text-face-name: @sans;
  text-wrap-width: 80;
  text-wrap-before: true;
  text-fill: #333;
  text-halo-fill: fadeout(#fff, 50%);
  text-halo-radius: 2;
  text-halo-rasterizer: fast;
  text-size: 10;
  text-line-spacing:-2;
  text-margin:25;

  // Cities
  [type='city'][zoom>=8][zoom<=15] {
  	text-face-name: @sans_md;
    text-size: 16;
    text-line-spacing:-7;

    [zoom>=10] { 
      text-size: 18;
      text-wrap-width: 140;
    }
    [zoom>=12] { 
      text-size: 24;
      text-wrap-width: 180;
    }
    // Hide at largest scales:
    [zoom>=16] { text-name: "''"; }
  }
  
  // Towns
  [type='town'] {
    text-size: 12;    
    text-halo-fill: fadeout(#fff, 50%);
    text-halo-radius: 2.5;
    [zoom>=12] { text-size: 12; }
    [zoom>=14] { text-size: 16; }
    [zoom>=16] { text-size: 22; }
    // Hide at largest scales:
    [zoom>=18] { text-name: "''"; }
  }
  
  // Villages and suburbs
  [type='village'] {
    text-size: 12;    
    text-halo-fill: fadeout(@land, 50%);
    text-halo-radius: 2;
    [zoom>=12] { text-size: 10; }
    [zoom>=14] { text-size: 14; }
    [zoom>=16] { text-size: 18; }
  }
  [type='hamlet'],
  [type='suburb'],
  [type='neighbourhood'] {
    text-fill: #633;
    text-face-name:	@sans_it;
    text-transform: none;
    text-margin:80;
    text-halo-radius: 2.5;
    text-character-spacing: 0.5;
    text-size: 14;
    [zoom>=14] { text-size: 15; }
    [zoom>=15] { text-size: 16; text-character-spacing: 1; }
    [zoom>=16] { text-size: 18; text-character-spacing: 2; }
    [zoom>=18] { text-size: 24; text-character-spacing: 3; }
  }
}


// ---------------------------------------------------------------------
// Points of interest

// Rail stations
#poi_label[type='Rail Station'][network!=null][scalerank=1][zoom>=10],
#poi_label[type='Rail Station'][network!=null][scalerank=2][zoom>=10],
#poi_label[type='Rail Station'][network!=null][scalerank=3][zoom>=10] {
  marker-file: url("rail/[network]-18.svg");
  marker-height: 12;
  marker-allow-overlap: false;

   [zoom>13] {
    marker-height:16;
  }
  [zoom>15] {
    marker-height:24;
    text-name: @name;
    text-face-name: @sans_md;
    text-fill: #333;
    text-halo-fill: #fff;
    text-halo-radius: 1;
    text-halo-rasterizer: fast;
    text-size: 12;
    text-wrap-width: 80;
    text-placement-type: simple;
    text-dx: 11; text-dy: 11;
    text-placements: "S,N,E,W";
        text-min-padding:1;
  }
  // text labels first come in at zoom 16
  [zoom>=16] {
      text-size: 12;
      text-halo-radius: 2;
      text-dx: 15; text-dy: 12;
      text-line-spacing:-2;
    }
  
}

#poi_label[zoom>=13][scalerank<=1],
#poi_label[zoom>=15][scalerank<=2],
#poi_label[zoom>=16][scalerank<=3],
#poi_label[zoom>=18][scalerank<=4][localrank<=2] {
  // Separate icon and label attachments are created to ensure that
  // all icon placement happens first, then labels are placed only
  // if there is still room.
  ::icon[maki!=null] {
    // The [maki] field values match a subset of Maki icon names, so we
    // can use that in our url expression.
    // Not all POIs have a Maki icon assigned, so we limit this section
    // to those that do. See also <https://www.mapbox.com/maki/>
    marker-fill:#888;
        marker-height:12;
    marker-file:url('icon/[maki]-12.svg');
  }
  ::label[type!='Rail Station'] {
    text-name: @name;
    text-face-name: @sans_md;
    text-size: 12;
    text-margin:1;
    text-fill: #888;
    text-halo-fill: fadeout(#fff, 50%);
    text-halo-radius: 1;
    text-halo-rasterizer: fast;
    text-wrap-width: 60;
    text-line-spacing:	-4;
    //text-transform: uppercase;
    //text-character-spacing:	0.25;
    // POI labels with an icon need to be offset:
    [maki!=null] { text-dy: 8; }
  }
}



// ---------------------------------------------------------------------
// Roads
@us-shield-name: "[ref].replace(';.*', '').replace('^[^\d]*', '')";
#road_label::us_shield[reflen>0][reflen<=6]{
  // Default shields
  shield-file: url("shield/motorway_[reflen].svg");
  shield-name: [ref];
  shield-face-name: 'PT Sans Bold', 'Open Sans Regular';
  shield-size: 11;
  shield-fill: #444;
  shield-min-padding: 50;
  shield-min-distance:120;
  shield-character-spacing:-0.5;
  [reflen>2]{shield-character-spacing:-0.75}
  [zoom>=11] { shield-min-distance: 100; }
  [zoom>=16] {   shield-min-padding: 50;}

  // 1 & 2 digit US state highways
  [ref =~ '^(AL|AK|AS|AZ|AR|CA|CO|CT|DE|DC|FM|FL|GA|GU|HI|ID|IL|IN|IA|KS|KY|LA|ME|MH|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MT|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VI|VA|WA|WV|WI|WY|SR)\ ?\d[\dA-Z]?(;.*|$)'] {
    shield-file: url(shield/us_state_2.svg);
    shield-name: @us-shield-name;
    shield-transform:scale(0.85,0.85);
    shield-character-spacing:-0.75;
  }
  // 3 digit US state highways
  [ref =~ '^(AL|AK|AS|AZ|AR|CA|CO|CT|DE|DC|FM|FL|GA|GU|HI|ID|IL|IN|IA|KS|KY|LA|ME|MH|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MT|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VI|VA|WA|WV|WI|WY|SR)\ ?\d\d[\dA-Z](;.*|$)'] {
    shield-file: url(shield/us_state_3.svg);
    shield-name: @us-shield-name;
    shield-character-spacing:-1;
    shield-transform:scale(0.85,0.85);
  }
  // 1 & 2 digit US highways
  [ref =~ '^US\ ?\d[\dA-Z]?(;.*|$)'] {
    shield-file: url(shield/us_highway_2.svg);
    shield-name: @us-shield-name;      
    shield-character-spacing:-0.5;
    shield-transform:scale(1.4, 1.4);
    [zoom>=14]{
          shield-character-spacing:-0.5;
    }

  }
  // 3 digit US highways
  [ref =~ '^US\ ?\d\d[\dA-Z](;.*|$)'] {
    shield-file: url(shield/us_highway_3.svg);
    shield-name: @us-shield-name;
    shield-character-spacing:-1.5;
    shield-transform:scale(1.4,1.4);

  }
  // 1 & 2 digit US Interstates
  [ref =~ '^I\ ?\d[\dA-Z]?(;.*|$)'] {
    shield-file: url(shield/us_interstate_2.svg);
    shield-name: @us-shield-name;
    shield-transform:scale(0.8,0.8);
    shield-character-spacing:-0.75;
    shield-fill: #fff;
    shield-dy: 0;
    [zoom>=10]{shield-dy: -1;}
    [zoom>=19]{shield-dy: 0;}
  }
  // 3 digit US Interstates
  [ref =~ '^I\ ?\d\d[\dA-Z](;.*|$)'] {
    shield-file: url(shield/us_interstate_3.svg);
    shield-name: @us-shield-name;
    shield-transform:scale(0.85,0.85);
    shield-fill: #fff;
    shield-character-spacing:-0.75;
    shield-dy: -1;
    [zoom>=13][zoom<=15]{shield-dy: -0.5;}
  }
}


#road_label {
  text-name: @name;
  text-placement: line;  // text follows line path
  text-face-name: @sans;
  text-fill: #333;
  text-halo-fill: fadeout(#fff, 75%);
  text-halo-radius: 2;
  text-halo-rasterizer: fast;
  text-size: 12;
  text-margin:20;
  text-avoid-edges: true;  // prevents clipped labels at tile edges
  [type='motorway'] {text-face-name: @sans_bd;  }

  [zoom>=15] { text-size: 13; }

}


// ---------------------------------------------------------------------
// Water

#water_label {
  [zoom<=13],  // automatic area filtering @ low zooms
  [zoom>=14][area>500000],
  [zoom>=16][area>10000],
  [zoom>=17] {
    text-name: @name;
    text-face-name: @sans_it;
    text-fill: darken(@water, 15);
    text-size: 12;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: fadeout(#fff, 75%);
    text-halo-radius: 1.5;
  }
}


// ---------------------------------------------------------------------
// House numbers

#housenum_label[zoom>=19] {
  text-name: [house_num];
  text-face-name: @sans_it;
  text-fill: #999;
  [zoom=19] { text-size: 10; }
  [zoom>=20] { text-size: 12; }
}