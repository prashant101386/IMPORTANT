param routeTable object
param tags object

resource symbolicname 'Microsoft.Network/routeTables@2022-07-01' = {
  name: routeTable.name
  location: routeTable.location
  tags: tags
  properties: {
    disableBgpRoutePropagation: routeTable.disableBgpRoutePropagation
    routes: routeTable.routes
  }
}
