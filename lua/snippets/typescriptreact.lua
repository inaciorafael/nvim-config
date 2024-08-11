local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function to_uppercase(args)
  return args[1][1]:upper()
end

return {
  s(
    "tscomponent",
    fmt(
      [[
    import React from 'react'

    const {component_name}: React.FC = () => {{
        return (
        <h1>{component_name}</h1>
        )
    }}

    export default {component_name}
    ]],
      {
        component_name = i(1, "component_name"),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
  s(
    "tsicomponent",
    fmt(
      [[
    import React from 'react'

    interface I{component_name}Props {{
        prop?: any
    }}

    const {component_name}: React.FC<I{component_name}Props> = () => {{
        return (
        <h1>{component_name}</h1>
        )
    }}

    export default {component_name}
    ]],
      {
        component_name = i(1, "component_name"),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
  s(
    "nutriencp",
    fmt(
      [[
    import React from "react";
    import {{ Box, Text }} from "@nutrien/bonsai-core";

    const {component_name} = () => {{
        return (
        <Box>
        <Text>{component_name}</Text>
        </Box>
        )
    }}

    export default {component_name};
    ]],
      {
        component_name = i(1, "component_name"),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
  s(
    "nutrienquery",
    fmt(
      [[
    import {{ gql, useQuery }} from '@apollo/client';

    export const {query_name} = gql`
      // QUERY_HERE
    `;

    interface QueryOptions {{
        skip? boolean;
    }}

    const {query_name} = (
    variables: IRequestQuery,
    options?: QueryOptions
    ) => {{
        return useQuery<IGetAllCustomersResponse, IRequestQuery>({query_name}, {{
            variables: {{
                ...variables,
            }},
            skip: options?.skip || false,
            notifyOnNetworkStatusChange: true,
        }});
    }};

    export default {query_name};
    ]],
      { query_name = i(1, "query_name") },
      {
        repeat_duplicates = true,
      },
      f(to_uppercase, { 1 })
    )
  ),
}
