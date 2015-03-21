
  PROGRAM

  Include('ConsoleSupport.inc'),ONCE
  Include('cpxml.inc'),ONCE
  Include('xmlclass.inc'),ONCE

                        MAP
Main                      PROCEDURE()
TraverseDOM             PROCEDURE(*Node pRoot, UNSIGNED pLevel=1)
                        END
Console                   ConsoleSupport
  CODE
  IF Console.Init() 
    Halt()
  END
  Main()
  Console.ReadKey()
  
Main                    PROCEDURE()
FileDoc                   &Document, AUTO
DocType                   &DocumentType, AUTO
CurrentElement            &element, AUTO
CurrentNode               &node, AUTO
  CODE
  
  Console.WriteLine('=================== XmlTest ===================')
  Console.WriteLine('View XML File PurchaseOrder.xml:')
  FileDoc &= XMLFileToDOM('PurchaseOrder.xml')
  ViewXml(FileDoc)

  Console.WriteLine('<13,10>Traverse XML Document: ')
  TraverseDOM(FileDoc)
  fileDoc.release()

TraverseDOM             PROCEDURE(*Node pRoot, UNSIGNED pLevel=1)
Nl                        &NodeList, AUTO
childIndex                UNSIGNED, AUTO
  CODE
  Nl &= pRoot.getChildNodes()
  Console.WriteLine('Node Name: ' & All(' ', (pLevel-1)*4) & pRoot.getNodeName() & ' ' & Clip(pRoot.getNodeValue()))
  assert(not Nl &= null)
  loop childIndex = 0 to Nl.getLength() - 1
    TraverseDOM(Nl.item(childIndex), pLevel+1)
  end
  Nl.release()