defmodule HandlerTest do
  use ExUnit.Case

  import Servy.Handler, only: [handle: 1]

  test "GET /wildthings" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 24\r
           \r
           Bears, Lions, Tigers🎉
           """
  end

  test "GET /bears" do
    request = """
    GET /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 431\r
    \r
    <hi>All The Bears!</h1>

    <ul>
     <li>Brutus - Grizzly </li>
     <li>Iceman - Polar </li>
     <li>Kenai - Grizzly </li>
     <li>Paddington - Brown </li>
     <li>Roscoe - Panda </li>
     <li>Rosie - Black </li>
     <li>Scarface - Grizzly </li>
     <li>Smokey - Black </li>
     <li>Snow - Polar </li>
     <li>Teddy - Brown </li>
    </ul>🎉
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /bigfoot" do
    request = """
    GET /bigfoot HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 404 Not Found\r
           Content-Type: text/html\r
           Content-Length: 17\r
           \r
           No /bigfoot here!
           """
  end

  test "GET /bears/1" do
    request = """
    GET /bears/1 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 81\r
    \r
    <h1>Show Bear</h1>
    <p>Is Teddy Hibernating? <strong> true </strong></p>🎉
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /wildlife" do
    request = """
    GET /wildlife HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 24\r
           \r
           Bears, Lions, Tigers🎉
           """
  end

  test "GET /bears?id=2" do
    request = """
    GET /bears?id=2 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 83\r
    \r
    <h1>Show Bear</h1>
    <p>Is Smokey Hibernating? <strong> false </strong></p>🎉
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /about" do
    request = """
    GET /about HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 343\r
    \r
    <h1>Clark's Wildthings Refuge</h1>

    <blockquote>
    When we contemplate the whole globe as one great dewdrop,striped and dotted with continents and islands, flying throughspace with other stars all singing and shining together as one,the whole universe appears as an infinite storm of beauty.-- John Muir
    </blockquote>🎉
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /pages/contact" do
    request = """
    GET /pages/contact HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 20\r
           \r
           <h1>Contact</h1>🎉
           """
  end

  test "GET /pages/faq" do
    request = """
    GET /pages/faq HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 16\r
           \r
           <h1>Faq</h1>🎉
           """
  end

  test "POST /bears" do
    request = """
    POST /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    Content-Type: application/x-www-form-urlencoded\r
    Content-Lenght: 21\r
    \r
    name=Baloo&type=Brown\r
    """

    response = handle(request)

    assert response == """
           HTTP/1.1 201 Created\r
           Content-Type: text/html\r
           Content-Length: 33\r
           \r
           Created a Brown bear named Baloo!
           """
  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end
