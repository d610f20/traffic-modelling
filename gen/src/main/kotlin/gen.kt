import org.w3c.dom.Document
import org.w3c.dom.Element
import java.io.File
import java.io.FileWriter
import java.util.function.Consumer
import javax.xml.parsers.DocumentBuilderFactory
import javax.xml.transform.Transformer
import javax.xml.transform.TransformerFactory
import javax.xml.transform.dom.DOMSource
import javax.xml.transform.stream.StreamResult


class Net(doc: Document) {
    private val edgeIndex = HashMap<String, Element>()
    private val laneIndex = HashMap<String, Element>()

    init {
        val root = doc.documentElement as Element
        val edges = root.getElementsByTagName("edge")
        for (i in 0 until edges.length) {
            val edge = edges.item(i) as Element
            val id = edge.getAttribute("id")
            edgeIndex[id] = edge

            val lanes = edge.getElementsByTagName("lane")
            for (o in 0 until lanes.length) {
                val lane = lanes.item(o) as Element
                val laneId = lane.getAttribute("id")
                laneIndex[laneId] = lane
            }
        }
    }
}

data class BusStop(val id: String, val laneId: String, val startPos: Int, val endPos: Int)

class Additional {
    val busstops = ArrayList<BusStop>()

    fun write(file: File) {
        val factory = DocumentBuilderFactory.newInstance()
        val builder = factory.newDocumentBuilder()
        val doc = builder.newDocument()

        val root = doc.createElement("additional");
        root.setAttribute(
            "xmlns:xsi",
            "http://www.w3.org/2001/XMLSchema-instance"
        )
        root.setAttribute(
            "xsi:noNamespaceSchemaLocation",
            "http://sumo.dlr.de/xsd/additional_file.xsd"
        )
        doc.appendChild(root)

        busstops.stream()
            .forEach { busstop ->
                val elem = doc.createElement("busStop")

                elem.setAttribute("id", busstop.id)
                elem.setAttribute("lane", busstop.laneId)
                elem.setAttribute("startPos", busstop.startPos.toString())
                elem.setAttribute("endPos", busstop.endPos.toString())

                root.appendChild(elem)
            }

        val source = DOMSource(doc)
        val writer = FileWriter(file)
        val result = StreamResult(writer)

        val transformerFactory = TransformerFactory.newInstance()
        val transformer: Transformer = transformerFactory.newTransformer()
        transformer.transform(source, result)
    }
}

// foo.add.xml - busstops
// foo.route.xml - routes

fun main() {
    val factory = DocumentBuilderFactory.newInstance()
    val builder = factory.newDocumentBuilder()

    val doc = builder.parse(File("../hello_net/hello.net.xml"))

    @Suppress("UNUSED_VARIABLE")
    val net = Net(doc)

    val additional = Additional()
    additional.busstops.add(BusStop(
        "foo",
        "bar",
        10,
        20
    ))

    additional.write(File("./foo.add.xml"))
}
