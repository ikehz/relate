module RESTfuls
  RESTFULS = {index:   {description: "GET #index",      action: :get,    method: :index},
              new:     {description: "GET #new",        action: :get,    method: :new},
              create:  {description: "POST #create",    action: :post,   method: :create},
              show:    {description: "GET #show",       action: :get,    method: :show},
              edit:    {description: "GET #edit",       action: :get,    method: :edit},
              update:  {description: "PATCH #update",   action: :patch,  method: :update},
              destroy: {description: "DELETE #destroy", action: :delete, method: :new}}
end
