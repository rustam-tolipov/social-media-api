require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: JWT
          }
        },
        schemas: {
          user_registration: {
            type: :object,
            properties: {
              first_name: {
                type: :string
              },
              last_name: {
                type: :string
              },
              username: {
                type: :string
              },
              email: {
                type: :string
              },
              password: {
                type: :string
              },
              password_confirmation: {
                type: :string
              },
            }
          },
          user_login: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
      },
      tags: [
        { name: 'Users' },
        { name: 'Authentication' },
        { name: 'Posts' },
        { name: 'Comments' },
        { name: 'Likes of Posts' },
        { name: 'Likes of Comments' },
        { name: 'Follows' },
        { name: 'Search' },
        { name: 'Suggestions' },
      ],
      paths: {
        '/api/v1/auth/signup': {
          post: {
            tags: ['Authentication'],
            summary: 'Creates a new user',
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                in: :body,
                name: :user,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      '$ref': '#/components/schemas/user_registration'
                    }
                  }
                },
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'User created'
              },
              '401': {
                description: 'User already exists'
              },
              '422': {
                description: 'Invalid request'
              },
              '500': {
                description: 'Internal server error'
              }
            }
          }
        },
        '/api/v1/auth/login': {
          post: {
            tags: ['Authentication'],
            summary: 'Logs in a user',
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                in: :body,
                name: :user,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      '$ref': '#/components/schemas/user_login'
                    }
                  }
                },

                required: true
              }
            ],
            responses: {
              '200': {
                description: 'User created'
              }
            }
          }
        },
        '/api/v1/auth/logout': {
          delete: {
            tags: ['Authentication'],
            security: [{ bearer_auth: [] }],
            summary: 'Logs out current logged in user',
            description: '',
            operationId: 'logout',
            parameters: [],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }

        },
        '/api/v1/auth/me': {
          get: {
            tags: ['Users'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns current logged in user',
            description: '',
            operationId: 'me',
            parameters: [],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/users/show/{username}': {
          get: {
            tags: ['Users'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns user by username',
            description: '',
            operationId: 'getUser',
            parameters: [
              {
                name: 'username',
                in: :path,
                description: 'Username of user',
                required: true,
                schema: {
                  type: :string
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/posts': {
          post: {
            tags: ['Posts'],
            security: [{ bearer_auth: [] }],
            summary: 'Creates a new post',
            description: '',
            operationId: 'createPost',
            consumes: ['multipart/form-data'],
            produces: ['application/json'],
            parameters: [
              {
                in: :formData,
                name: :post,
                description: 'Post to create',
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    image: {
                      type: :file
                },
                    content: {
                      type: :string
                    }
                  }
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          },
          get: {
            tags: ['Posts'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns all posts',
            description: '',
            operationId: 'getPosts',
            parameters: [],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/posts/{id}': {
          get: {
            tags: ['Posts'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns a post',
            description: '',
            operationId: 'getPost',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to return',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          },
          put: {
            tags: ['Posts'],
            security: [{ bearer_auth: [] }],
            summary: 'Updates a post',
            description: '',
            operationId: 'updatePost',
            consumes: ['multipart/form-data'],
            produces: ['application/json'],
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to update',
                required: true,
                schema: {
                  type: :integer
                }
              },
              {
                in: :formData,
                name: :post,
                description: 'Post to update',
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    image: {
                      type: :file
                },
                    content: {
                      type: :string
                    }
                  }
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          },
          delete: {
            tags: ['Posts'],
            security: [{ bearer_auth: [] }],
            summary: 'Deletes a post',
            description: '',
            operationId: 'deletePost',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to delete',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/posts/{id}/comments': {
          post: {
            tags: ['Comments'],
            security: [{ bearer_auth: [] }],
            summary: 'Creates a new comment',
            description: '',
            operationId: 'createComment',
            consumes: ['multipart/form-data'],
            produces: ['application/json'],
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to comment on',
                required: true,
                schema: {
                  type: :integer
                }
              },
              {
                in: :formData,
                name: :comment,
                description: 'Comment to create',
                required: true,
                schema: {
                  type: :object,
                  properties: {
                    content: {
                      type: :string
                    }
                  }
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/posts/{id}/like': {
          post: {
            tags: ['Likes of Posts'],
            security: [{ bearer_auth: [] }],
            summary: 'Likes a post',
            description: '',
            operationId: 'likePost',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to like',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          },
          delete: {
            tags: ['Likes of Posts'],
            security: [{ bearer_auth: [] }],
            summary: 'Unlikes a post',
            description: '',
            operationId: 'unlikePost',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to unlike',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/posts/{id}/comments/{commentId}/like': {
          post: {
            tags: ['Likes of Comments'],
            security: [{ bearer_auth: [] }],
            summary: 'Likes a comment',
            description: '',
            operationId: 'likeComment',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to comment on',
                required: true,
                schema: {
                  type: :integer
                }
              },
              {
                in: :path,
                name: :commentId,
                description: 'ID of comment to like',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          },
          delete: {
            tags: ['Likes of Comments'],
            security: [{ bearer_auth: [] }],
            summary: 'Unlikes a comment',
            description: '',
            operationId: 'unlikeComment',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of post to comment on',
                required: true,
                schema: {
                  type: :integer
                }
              },
              {
                in: :path,
                name: :commentId,
                description: 'ID of comment to unlike',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/users/{id}/follow': {
          post: {
            tags: ['Follows'],
            security: [{ bearer_auth: [] }],
            summary: 'Follows a user',
            description: '',
            operationId: 'followUser',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of user to follow',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          },
        },
        '/api/v1/users/{id}/unfollow': {
          delete: {
            tags: ['Follows'],
            security: [{ bearer_auth: [] }],
            summary: 'Unfollows a user',
            description: '',
            operationId: 'unfollowUser',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of user to unfollow',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/users/{id}/followers': {
          get: {
            tags: ['Follows'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns all followers of a user',
            description: '',
            operationId: 'getFollowers',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of user to get followers of',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/users/{id}/following': {
          get: {
            tags: ['Follows'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns all users a user is following',
            description: '',
            operationId: 'getFollowing',
            parameters: [
              {
                in: :path,
                name: :id,
                description: 'ID of user to get following of',
                required: true,
                schema: {
                  type: :integer
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/search?username={username}': {
          get: {
            tags: ['Search'],
            security: [{ bearer_auth: [] }],
            summary: 'Searches for a user by username',
            description: '',
            operationId: 'searchUser',
            parameters: [
              {
                in: :query,
                name: :username,
                description: 'Username to search for',
                required: true,
                schema: {
                  type: :string
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/suggestions': {
          get: {
            tags: ['Suggestions'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns suggestions for users to follow',
            description: '',
            operationId: 'getSuggestions',
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'https://{flyHost}',
          variables: {
            flyHost: {
              default: 'social-media-api.fly.dev'
            }
          }
        },
        {
          url: 'http://{localhost}',
          variables: {
            localhost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
