//
//  Pros.swift
//  KampusChat
//
//  Created by Burak on 21.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation

/*
Notes
 
 - Dış sınıfa ait fonksiyonlar olabildiğince üzerinde çalışılan sınıfın metodları ile çağrılmalıdır.
  Nedeni sınıfın bağımlı olduğu dış sınıfın projeden  çıkarılması ile birlikte sınıfın olaydan en az biçimde etkilenmesini ve kolayca güncellenebilmesini sağlamak.
 
 - Farklı durumları if yada switch case yapısı kullanarak ortak bir metodda yapmak yerine farklı metodlar kullanarak yapmak bagımlılığı azaltır.
 
 - Yazılımın en uç noktasında(View Controller) sınıflar neredeyse aynı işi yapsa bile farklılıkları bağımsız(biri gidince diğerleri etkilenmez) şekilde kontrol edebilmek için sınıfları ayrı ayrı oluşturmak gerekir.
 
 - Dependency injection altında yatan mantık bağımlı olunan sınıfın bağımlı olduğu sınıflarla uğramama prensibi üzerinedir.Sadece sınıfla ilgilenilir.
 
 - Dependecy injection Unit testlerde kolayca mock classları oluşturabilme kabiliyeti verdiği için avantaj sağlar.
 
 - Class içindeki fonksiyonları olabildiğince tek görev şeklinde parçalara ayırmak kodun işlevselliğini ve yenilenebilirliğini arttırır.
 
 */
